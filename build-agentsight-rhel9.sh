#!/usr/bin/env bash
# build-agentsight-rhel9.sh — build AgentSight from source on RHEL 9, including air-gapped hosts.
#
# Why: the official AgentSight release binaries need glibc >= 2.39, and the eBPF
# probe binaries committed to the repo need glibc >= 2.38. RHEL 9 ships glibc
# 2.34, so AgentSight must be built from source there.
#
# Two stages:
#   bundle  (connected machine)  Downloads everything into one tarball: AgentSight
#                                source + submodules, vendored Rust crates, a
#                                standalone Rust toolchain and, optionally, build RPMs.
#   build   (air-gapped RHEL 9)  Builds from that tarball with no network access.
#
#   all     (connected RHEL 9)   bundle + build in one go.
#
# Examples:
#   ./build-agentsight-rhel9.sh bundle --with-rpms            # -> agentsight-v1.0.31-rhel9-bundle.tar.gz
#   # copy the tarball and its .sha256 to the air-gapped host, then:
#   ./build-agentsight-rhel9.sh build --bundle agentsight-v1.0.31-rhel9-bundle.tar.gz --install-rpms
#
# Disk space: everything (including compiler temp files) goes under a work
# directory, by default ./agentsight-rhel9-work in the current directory, not
# /tmp. A build needs about 4 GB free there; a bundle about 2 GB.
#
# Run with -h for all options.

set -euo pipefail

# ---------------------------------------------------------------- defaults ---
AGENTSIGHT_REPO="${AGENTSIGHT_REPO:-https://github.com/eunomia-bpf/agentsight.git}"
AGENTSIGHT_VERSION="${AGENTSIGHT_VERSION:-v1.0.31}"
RUST_VERSION="${RUST_VERSION:-1.98.1}"          # AgentSight needs >= 1.87
RUST_TARGET="x86_64-unknown-linux-gnu"
RUST_DIST_URL="${RUST_DIST_URL:-https://static.rust-lang.org/dist}"
BUILD_RPMS=(gcc make clang llvm elfutils-libelf-devel zlib-devel binutils tar xz gzip)

OUT_DIR="$PWD"
WORK_DIR=""
BUNDLE=""
PREFIX="$HOME/.local/bin"
WITH_RPMS=0
INSTALL_RPMS=0
KEEP_WORK=0
MIN_FREE_GB=""
WORK_BASE="$PWD/agentsight-rhel9-work"

# ----------------------------------------------------------------- helpers ---
log()  { printf '\033[1;34m==>\033[0m %s\n' "$*" >&2; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }
need() { command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"; }

usage() {
    sed -n '2,21p' "$0" | sed 's/^# \{0,1\}//'
    cat <<EOF

Usage: $(basename "$0") <bundle|build|all> [options]

Common options:
  --version TAG        AgentSight git tag to build        (default: $AGENTSIGHT_VERSION)
  --work-dir DIR       Scratch directory; also used as TMPDIR for all tools
                       (default: a new directory under ./agentsight-rhel9-work)
  --keep-work          Keep the scratch directory after a successful run
                       (it is always kept after a failure, for the logs)
  --min-free-gb N      Required free space in the work directory
                       (default: 4 for build/all, 2 for bundle; 0 disables the check)
  -h, --help           Show this help

bundle options:
  --rust VERSION       Standalone Rust toolchain to bundle (default: $RUST_VERSION)
  --out DIR            Where to write the bundle tarball   (default: current directory)
  --with-rpms          Also download build RPMs and their dependencies with
                       'dnf download' (bundle host must be RHEL 9 with repos enabled)

build options:
  --bundle FILE        Bundle tarball from the 'bundle' stage (required for 'build')
  --prefix DIR         Install directory for the agentsight binary (default: $PREFIX)
  --install-rpms       Install the bundled RPMs with 'sudo dnf' from local files only

Environment overrides: AGENTSIGHT_REPO, AGENTSIGHT_VERSION, RUST_VERSION, RUST_DIST_URL
EOF
}

max_glibc() {  # highest GLIBC_x.y symbol version an ELF file requires
    objdump -T "$1" 2>/dev/null | grep -oE 'GLIBC_[0-9]+\.[0-9]+(\.[0-9]+)?' | sed 's/GLIBC_//' | sort -Vu | tail -1
}

system_glibc() { getconf GNU_LIBC_VERSION | awk '{print $2}'; }

version_le() { [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -1)" = "$1" ]; }

TEMP_WORK=0
cleanup_work_dir() {  # remove an auto-created work dir after success; keep it after failure
    local status=$?
    [ "$TEMP_WORK" = 1 ] && [ -n "$WORK_DIR" ] || return 0
    if [ "$status" -eq 0 ] && [ "$KEEP_WORK" != 1 ]; then
        rm -rf "$WORK_DIR"
        rmdir "$WORK_BASE" 2>/dev/null || true
    else
        warn "work directory kept: $WORK_DIR (delete it when finished)"
    fi
}

check_free_space() {  # check_free_space <dir> <GB>
    local dir="$1" need_gb="$2" avail_kb
    [ "$need_gb" -gt 0 ] || return 0
    avail_kb="$(df -Pk "$dir" | awk 'NR==2 {print $4}')"
    if [ "$avail_kb" -lt $((need_gb * 1024 * 1024)) ]; then
        die "only $((avail_kb / 1024)) MB free in $dir, need about ${need_gb} GB.
       Run from a directory on a bigger filesystem, or pass --work-dir DIR (--min-free-gb 0 skips this check)."
    fi
}

setup_work_dir() {  # setup_work_dir <default-min-free-gb>
    if [ -z "$WORK_DIR" ]; then
        check_free_space "$(dirname "$WORK_BASE")" "${MIN_FREE_GB:-$1}"
        mkdir -p "$WORK_BASE"
        WORK_DIR="$(mktemp -d "$WORK_BASE/$CMD.XXXXXX")"
        TEMP_WORK=1
        trap cleanup_work_dir EXIT
    else
        mkdir -p "$WORK_DIR"
        check_free_space "$WORK_DIR" "${MIN_FREE_GB:-$1}"
    fi
    # Keep every tool's temporary files (rustc, cc, cargo, git, the Rust
    # installer) inside the work directory instead of a possibly small /tmp.
    export TMPDIR="$WORK_DIR/tmp"
    mkdir -p "$TMPDIR"
    log "work directory: $WORK_DIR ($(df -Ph "$WORK_DIR" | awk 'NR==2 {print $4}') free)"
}

# ------------------------------------------------------------------ bundle ---
cmd_bundle() {
    need git; need curl; need tar; need sha256sum
    setup_work_dir 2
    local name="agentsight-${AGENTSIGHT_VERSION}-rhel9-bundle"
    local root="$WORK_DIR/$name"
    rm -rf "$root"; mkdir -p "$root"

    log "cloning AgentSight $AGENTSIGHT_VERSION"
    git -c advice.detachedHead=false clone -q --depth 1 --branch "$AGENTSIGHT_VERSION" \
        "$AGENTSIGHT_REPO" "$root/agentsight"
    local commit; commit="$(git -C "$root/agentsight" rev-parse HEAD)"

    log "fetching eBPF submodules (libbpf, bpftool and bpftool's nested libbpf)"
    git -C "$root/agentsight" submodule update -q --init --depth 1 libbpf bpftool
    git -C "$root/agentsight/bpftool" submodule update -q --init --depth 1

    log "downloading standalone Rust $RUST_VERSION toolchain"
    local rust_pkg="rust-${RUST_VERSION}-${RUST_TARGET}.tar.xz"
    mkdir -p "$root/toolchain"
    curl -fsSL --retry 3 "$RUST_DIST_URL/$rust_pkg" -o "$root/toolchain/$rust_pkg"
    curl -fsSL --retry 3 "$RUST_DIST_URL/$rust_pkg.sha256" -o "$root/toolchain/$rust_pkg.sha256"
    ( cd "$root/toolchain" && echo "$(awk '{print $1}' "$rust_pkg.sha256")  $rust_pkg" | sha256sum -c --quiet ) \
        || die "Rust toolchain checksum mismatch"

    log "vendoring Rust crates for offline builds"
    local cargo_bin
    if command -v cargo >/dev/null 2>&1; then
        cargo_bin="$(command -v cargo)"
    else
        # Use the toolchain we just downloaded; no rustup needed on the bundle host.
        install_rust "$root/toolchain/$rust_pkg" "$WORK_DIR/rust-bundle-host"
        cargo_bin="$WORK_DIR/rust-bundle-host/bin/cargo"
    fi
    ( cd "$root/agentsight/collector" &&
      CARGO_HOME="$WORK_DIR/cargo-home" "$cargo_bin" vendor --locked --versioned-dirs \
          "$root/cargo-vendor" > "$root/cargo-vendor-config.toml" 2> "$WORK_DIR/cargo-vendor.log" ) \
        || { tail -20 "$WORK_DIR/cargo-vendor.log" >&2; die "cargo vendor failed"; }

    if [ "$WITH_RPMS" = 1 ]; then
        need dnf
        log "downloading build RPMs and dependencies: ${BUILD_RPMS[*]}"
        mkdir -p "$root/rpms"
        dnf -q download --resolve --alldeps --destdir "$root/rpms" "${BUILD_RPMS[@]}" \
            || die "dnf download failed (is this a RHEL 9 host with enabled repositories?)"
        log "downloaded $(ls "$root/rpms" | wc -l) RPMs"
    fi

    log "stripping git metadata"
    find "$root/agentsight" -name .git -prune -exec rm -rf {} +

    {
        printf 'agentsight_version=%q\n' "$AGENTSIGHT_VERSION"
        printf 'agentsight_commit=%q\n'  "$commit"
        printf 'rust_version=%q\n'       "$RUST_VERSION"
        printf 'rust_package=%q\n'       "$rust_pkg"
        printf 'rpms_included=%q\n'      "$WITH_RPMS"
        printf 'created=%q\n'            "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
        printf 'created_on=%q\n'         "$(uname -srm)"
    } > "$root/BUNDLE-INFO"
    cp "$0" "$root/build-agentsight-rhel9.sh"

    mkdir -p "$OUT_DIR"
    local tarball="$OUT_DIR/$name.tar.gz"
    log "writing $tarball"
    tar -C "$WORK_DIR" --owner=0 --group=0 --numeric-owner -czf "$tarball" "$name"
    ( cd "$OUT_DIR" && sha256sum "$name.tar.gz" > "$name.tar.gz.sha256" )
    log "bundle ready: $tarball ($(du -h "$tarball" | cut -f1))"
    log "checksum:     $tarball.sha256"
    BUNDLE="$tarball"
}

# ------------------------------------------------------------------- build ---
install_rust() {  # install_rust <rust-*.tar.xz> <prefix>
    local pkg="$1" prefix="$2" tmp
    tmp="$(mktemp -d "$WORK_DIR/rust-extract.XXXXXX")"
    tar -C "$tmp" --no-same-owner -xJf "$pkg"
    "$tmp"/rust-*/install.sh --prefix="$prefix" --components=rustc,cargo,rustfmt-preview,rust-std-${RUST_TARGET} \
        --disable-ldconfig >/dev/null
    rm -rf "$tmp"
}

check_build_deps() {
    local missing=()
    for p in "${BUILD_RPMS[@]}"; do rpm -q "$p" >/dev/null 2>&1 || missing+=("$p"); done
    if [ "${#missing[@]}" -gt 0 ]; then
        if [ "$INSTALL_RPMS" = 1 ] && [ -d "$SRC_ROOT/rpms" ]; then
            log "installing bundled RPMs (local files only, no repositories)"
            sudo dnf -y --disablerepo='*' install "$SRC_ROOT"/rpms/*.rpm
        else
            die "missing build packages: ${missing[*]}
       Install them from your local mirror, or re-run with --install-rpms using a bundle made with --with-rpms."
        fi
    fi
}

check_runtime_env() {
    [ -e /sys/kernel/btf/vmlinux ] || warn "/sys/kernel/btf/vmlinux not found: eBPF probes (CO-RE) will not load on this kernel"
    if [ -r "/boot/config-$(uname -r)" ]; then
        for opt in CONFIG_BPF_SYSCALL CONFIG_DEBUG_INFO_BTF CONFIG_UPROBES; do
            grep -q "^$opt=y" "/boot/config-$(uname -r)" || warn "$opt is not enabled in the running kernel"
        done
    fi
}

cmd_build() {
    [ -n "$BUNDLE" ] || die "--bundle FILE is required for 'build'"
    [ -f "$BUNDLE" ] || die "bundle not found: $BUNDLE"
    need tar; need rpm
    setup_work_dir 4

    if [ -f "$BUNDLE.sha256" ]; then
        log "verifying bundle checksum"
        ( cd "$(dirname "$BUNDLE")" && sha256sum -c --quiet "$(basename "$BUNDLE").sha256" ) \
            || die "bundle checksum mismatch"
    else
        warn "no $BUNDLE.sha256 next to the bundle; skipping checksum verification"
    fi

    log "extracting bundle"
    tar -C "$WORK_DIR" --no-same-owner -xzf "$BUNDLE"
    SRC_ROOT="$(find "$WORK_DIR" -mindepth 1 -maxdepth 1 -type d -name 'agentsight-*-rhel9-bundle' | head -1)"
    [ -n "$SRC_ROOT" ] || die "bundle does not contain an agentsight-*-rhel9-bundle directory"
    # shellcheck disable=SC1091
    . "$SRC_ROOT/BUNDLE-INFO"
    RUST_VERSION="$rust_version"
    log "AgentSight $agentsight_version ($agentsight_commit), Rust $rust_version"

    check_build_deps
    need objdump; need getconf
    check_runtime_env

    log "installing Rust $RUST_VERSION into the work directory (no system changes)"
    local rust_prefix="$WORK_DIR/rust"
    install_rust "$SRC_ROOT/toolchain/$rust_package" "$rust_prefix"
    export PATH="$rust_prefix/bin:$PATH"
    export CARGO_HOME="$WORK_DIR/cargo-home"
    mkdir -p "$CARGO_HOME"
    # Point cargo at the vendored crates only.
    sed "s#directory = \".*\"#directory = \"$SRC_ROOT/cargo-vendor\"#" \
        "$SRC_ROOT/cargo-vendor-config.toml" > "$CARGO_HOME/config.toml"
    printf '\n[net]\noffline = true\n' >> "$CARGO_HOME/config.toml"

    local src="$SRC_ROOT/agentsight"
    log "building eBPF probes against system glibc $(system_glibc)"
    make -C "$src/bpf" -j"$(nproc)" process sslsniff stdiocap > "$WORK_DIR/bpf-build.log" 2>&1 \
        || { tail -30 "$WORK_DIR/bpf-build.log" >&2; die "eBPF build failed (full log: $WORK_DIR/bpf-build.log)"; }

    # Replace the committed probe binaries (built against glibc 2.38) with ours.
    # The committed frontend in collector/vendor/frontend is used as-is (no Node.js needed).
    for p in process sslsniff stdiocap; do
        install -m 0755 "$src/bpf/$p" "$src/agentsight-capture/vendor/bpf/$p"
    done

    log "building agentsight CLI (offline)"
    ( cd "$src/collector" && cargo build --release --offline --locked ) > "$WORK_DIR/cargo-build.log" 2>&1 \
        || { tail -30 "$WORK_DIR/cargo-build.log" >&2; die "cargo build failed (full log: $WORK_DIR/cargo-build.log)"; }

    local bin="$src/collector/target/release/agentsight" sys need_glibc f
    sys="$(system_glibc)"
    for f in "$bin" "$src"/bpf/{process,sslsniff,stdiocap}; do
        need_glibc="$(max_glibc "$f")"
        version_le "$need_glibc" "$sys" || die "$(basename "$f") needs glibc $need_glibc but the system has $sys"
    done
    log "glibc check passed: binaries need <= $sys"

    mkdir -p "$PREFIX"
    install -m 0755 "$bin" "$PREFIX/agentsight"
    log "installed: $PREFIX/agentsight ($("$PREFIX/agentsight" --version))"
    sha256sum "$PREFIX/agentsight"
    case ":$PATH:" in *":$PREFIX:"*) ;; *) warn "$PREFIX is not on PATH" ;; esac
}

# -------------------------------------------------------------------- main ---
[ $# -ge 1 ] || { usage; exit 1; }
CMD="$1"; shift
while [ $# -gt 0 ]; do
    case "$1" in
        --version)      AGENTSIGHT_VERSION="$2"; shift 2 ;;
        --rust)         RUST_VERSION="$2"; shift 2 ;;
        --out)          OUT_DIR="$(realpath -m "$2")"; shift 2 ;;
        --work-dir)     WORK_DIR="$(realpath -m "$2")"; shift 2 ;;
        --bundle)       BUNDLE="$(realpath -m "$2")"; shift 2 ;;
        --prefix)       PREFIX="$(realpath -m "$2")"; shift 2 ;;
        --with-rpms)    WITH_RPMS=1; shift ;;
        --install-rpms) INSTALL_RPMS=1; shift ;;
        --keep-work)    KEEP_WORK=1; shift ;;
        --min-free-gb)  MIN_FREE_GB="$2"; shift 2 ;;
        -h|--help)      usage; exit 0 ;;
        *)              die "unknown option: $1 (see --help)" ;;
    esac
done

[ "$(uname -m)" = x86_64 ] || die "only x86_64 is supported (got $(uname -m))"

case "$CMD" in
    bundle) cmd_bundle ;;
    build)  cmd_build ;;
    all)    cmd_bundle
            if [ "$TEMP_WORK" = 1 ]; then
                [ "$KEEP_WORK" = 1 ] || rm -rf "$WORK_DIR"
                WORK_DIR=""; TEMP_WORK=0
            fi
            cmd_build ;;
    -h|--help|help) usage ;;
    *) usage; exit 1 ;;
esac
