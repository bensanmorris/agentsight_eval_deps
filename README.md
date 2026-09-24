# AgentSight RHEL 9 Offline Build Bundle

This repository holds a pre-downloaded, checksummed bundle for building [AgentSight](https://github.com/eunomia-bpf/agentsight) from source on **RHEL 9** hosts that can't reach GitHub source repos, crates.io or static.rust-lang.org.

It accompanies the evaluation in [bensanmorris/agentsight_eval](https://github.com/bensanmorris/agentsight_eval).

**Why a source build?** The official AgentSight release binaries need glibc 2.39, but RHEL 9 ships glibc 2.34. See the [evaluation results](https://github.com/bensanmorris/agentsight_eval/blob/main/RESULTS.md).

## Contents

| Path | What it is |
|---|---|
| `build-agentsight-rhel9.sh` | Build script; its `build` stage runs fully offline. **Use this copy**: it's newer than the one inside the bundle and keeps all work (including compiler temp files) out of `/tmp`. |
| `patches/v1.0.31/*.patch` | Patches that `build` applies automatically before compiling (see [Patches](#patches)) |
| `v1.0.31/agentsight-v1.0.31-rhel9-bundle.tar.gz.part-0{0..3}` | The bundle, split into parts of ≤90 MB (GitHub rejects files over 100 MB) |
| `v1.0.31/parts.sha256` | SHA-256 of each part |
| `v1.0.31/agentsight-v1.0.31-rhel9-bundle.tar.gz.sha256` | SHA-256 of the reassembled bundle |
| `v1.0.31/reassemble.sh` | Joins the parts and verifies both sets of checksums |
| `v1.0.31/THIRD-PARTY-LICENSES.md` | License inventory of everything in the bundle, **including notes for compliance review** |

Bundle SHA-256: `8e13225f1c6598aacbcbc00696a79c4d99f705fee7e1f4f9144155dba0a5995d` (343,763,757 bytes)

## What's inside the bundle

| Component | Version / pin | Source |
|---|---|---|
| AgentSight source | tag `v1.0.31`, commit `bb99b66f8f98e4b9f8b1769a3da0a8fbbe26b6c3` | github.com/eunomia-bpf/agentsight |
| libbpf, bpftool (+ bpftool's nested libbpf) | submodule commits pinned by that tag | github.com/libbpf |
| Vendored Rust crates (355) | exact versions and checksums from `collector/Cargo.lock` (`cargo vendor --locked`) | crates.io |
| Rust toolchain | 1.98.1 standalone installer; SHA-256 checked against rust-lang.org when bundled | static.rust-lang.org |

It has no build RPMs and no prebuilt binaries: the eBPF probes and the CLI are compiled on the target host. Provenance details are in `BUNDLE-INFO` inside the tarball.

## Usage on the air-gapped / corporate RHEL 9 host

Build prerequisites come from your normal RHEL repos or Satellite:

```bash
sudo dnf install -y gcc make clang llvm elfutils-libelf-devel zlib-devel binutils tar xz gzip
```

Then, from a directory on a filesystem with **about 5 GB free** (e.g. your home directory, **not** `/tmp`):

```bash
git clone https://github.com/bensanmorris/agentsight_eval_deps.git
cd agentsight_eval_deps
./v1.0.31/reassemble.sh             # -> ./agentsight-bundle/ (~330 MB)
./build-agentsight-rhel9.sh build --bundle agentsight-bundle/agentsight-v1.0.31-rhel9-bundle.tar.gz
agentsight --version                # agentsight 1.0.31, installed to ~/.local/bin
```

### Patches

`build` applies every `*.patch` in `patches/<version>/` before compiling. It checks each one with a dry run first, logs the patch's SHA-256, and stops with a clear error if a patch doesn't apply. The bundle itself stays pristine upstream source.

| Patch | Fixes |
|---|---|
| `0001-bpf-use-syscall_trace-structs-for-syscalls-tracepoints.patch` | AgentSight's syscall probes use the wrong tracepoint struct. On RHEL 9 (12-byte `trace_entry`) this makes stdio capture fail to attach (`-EACCES`) and file paths come out as garbage. It changes 29 lines, types only. See the [evaluation write-up](https://github.com/bensanmorris/agentsight_eval/blob/main/RESULTS.md#f31-fix-verified-on-rhel-98). |

Options: `--no-patches` builds unmodified upstream; `--patches DIR` uses a different patch directory.

### Disk space and `/tmp`

Nothing is written to `/tmp`. Everything happens under the current directory:

| Item | Location | Size |
|---|---|---|
| Git clone (history + checked-out parts) | `./` | ~660 MB |
| Reassembled bundle | `./agentsight-bundle/` | ~330 MB |
| Build work dir: extracted source, Rust toolchain, compiler output; `TMPDIR` also points here | `./agentsight-rhel9-work/build.XXXXXX/` | peak ~2.4 GB, **deleted after a successful build**, kept after a failure (for its logs) |

The build checks for 4 GB free before starting. To put the work directory elsewhere, use `--work-dir /path/with/space` (and `reassemble.sh /path/with/space`). `--min-free-gb 0` skips the check.

When the build has succeeded you can reclaim space with `rm -rf agentsight-bundle`. You can delete the whole clone too: the installed binary in `~/.local/bin` is self-contained.

Tested on RHEL 9.8 in a namespace with no network and a 50 MB `/tmp`. The previous version of the script failed there with "No space left on device", and this version completes.

`build` verifies the bundle checksum and installs Rust into a temporary directory only (nothing system-wide). It builds the eBPF probes against the host's glibc, compiles the CLI with `cargo --offline --locked`, and refuses to install if any binary needs a newer glibc than the host has. It was tested on RHEL 9.8 inside a network namespace with no network access.

## Integrity and trust

- `parts.sha256` and the bundle `.sha256` protect against corrupted or incomplete downloads. They **don't** prove who published the files, because anyone who can change the repo can change the checksums too. For stronger assurance, rebuild the bundle yourself on a connected host with `./build-agentsight-rhel9.sh bundle` and compare. The upstream inputs are pinned, although tarball timestamps will differ, so compare the extracted contents, not the tarball hash.
- If your organisation restricts which external sources may be used on corporate machines, have this bundle approved through your normal software-intake process before use.

## Rebuilding / updating the bundle

On a connected Linux x86-64 host:

```bash
./build-agentsight-rhel9.sh bundle --version v1.0.31      # or a newer tag
mkdir -p v<ver> && split -b 90M -d -a 2 agentsight-<tag>-rhel9-bundle.tar.gz v<ver>/agentsight-<tag>-rhel9-bundle.tar.gz.part-
```

Each new version adds about 350 MB to this repository's history.
