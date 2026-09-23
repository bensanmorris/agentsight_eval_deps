# Third-party licenses — agentsight v1.0.31 RHEL 9 bundle

This file was generated from the bundle contents. Each vendored crate keeps its own license files under `cargo-vendor/<crate>-<version>/`.

## Notes for legal / compliance review

- **`auto_generate_cdp` 0.4.6 is GPL-3.0-only.** Its `Cargo.toml` has no SPDX expression; the license comes from `LICENSE.txt`. It's a **build-time** dependency: `headless_chrome`'s build script runs it to generate Chrome DevTools Protocol bindings. It's distributed here as verbatim source with its license file, which GPL-3.0 §4 permits. Confirm with your legal team that a GPL-3.0 build tool is acceptable under your policy.
- **`option-ext` 0.2.0 is MPL-2.0** (file-level copyleft). It's distributed unmodified, with its source.
- Everything else is permissive (MIT, Apache-2.0, BSD, ISC, Zlib, Unicode-3.0, Unlicense, CDLA-Permissive-2.0, BSL-1.0), or LGPL/GPL offered as an alternative to a permissive license (libbpf, bpftool, 2 crates).
- **No Red Hat RPMs are included** (`rpms_included=0` in `BUNDLE-INFO`).

## Top-level components

| Component | Version | License |
|---|---|---|
| AgentSight (eunomia-bpf/agentsight) | v1.0.31 (`bb99b66f`) | MIT |
| libbpf (submodule) | `7a6e6b48` | LGPL-2.1 OR BSD-2-Clause |
| bpftool (submodule, incl. nested libbpf `5e3306e8`) | `5b402ffd` | GPL-2.0-only OR BSD-2-Clause |
| Rust standalone toolchain (static.rust-lang.org) | 1.98.1 | MIT OR Apache-2.0 (bundled components carry their own notices) |

## Vendored Rust crates (355)

### Summary by license expression

| License expression | Crates |
|---|---|
| `MIT OR Apache-2.0` | 194 |
| `MIT` | 63 |
| `Unicode-3.0` | 18 |
| `Apache-2.0 OR MIT` | 15 |
| `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` | 13 |
| `MIT/Apache-2.0` | 11 |
| `Unlicense OR MIT` | 6 |
| `BSD-3-Clause` | 5 |
| `Zlib` | 3 |
| `Apache-2.0` | 3 |
| `Zlib OR Apache-2.0 OR MIT` | 2 |
| `MIT OR Apache-2.0 OR LGPL-2.1-or-later` | 2 |
| `ISC` | 2 |
| `Unlicense/MIT` | 2 |
| `CDLA-Permissive-2.0` | 2 |
| `BSD-2-Clause OR Apache-2.0 OR MIT` | 2 |
| `0BSD OR MIT OR Apache-2.0` | 1 |
| `license-file: LICENSE.txt` | 1 |
| `BSD-3-Clause AND MIT` | 1 |
| `BSD-3-Clause/MIT` | 1 |
| `Apache-2.0 / MIT` | 1 |
| `MIT OR Zlib OR Apache-2.0` | 1 |
| `MPL-2.0` | 1 |
| `Apache-2.0 AND ISC` | 1 |
| `Apache-2.0 OR ISC OR MIT` | 1 |
| `Apache-2.0 OR BSL-1.0` | 1 |
| `Apache-2.0/MIT` | 1 |
| `(MIT OR Apache-2.0) AND Unicode-3.0` | 1 |

### All crates

| Crate | Version | License |
|---|---|---|
| adler2 | 2.0.1 | `0BSD OR MIT OR Apache-2.0` |
| adler32 | 1.2.0 | `Zlib` |
| ahash | 0.8.12 | `MIT OR Apache-2.0` |
| aho-corasick | 1.1.5 | `Unlicense OR MIT` |
| alloc-no-stdlib | 2.0.4 | `BSD-3-Clause` |
| alloc-stdlib | 0.2.4 | `BSD-3-Clause` |
| allocator-api2 | 0.2.21 | `MIT OR Apache-2.0` |
| android_system_properties | 0.1.6 | `MIT OR Apache-2.0` |
| anstream | 1.0.0 | `MIT OR Apache-2.0` |
| anstyle | 1.0.14 | `MIT OR Apache-2.0` |
| anstyle-parse | 1.0.0 | `MIT OR Apache-2.0` |
| anstyle-query | 1.1.5 | `MIT OR Apache-2.0` |
| anstyle-wincon | 3.0.11 | `MIT OR Apache-2.0` |
| anyhow | 1.0.104 | `MIT OR Apache-2.0` |
| async-stream | 0.3.6 | `MIT` |
| async-stream-impl | 0.3.6 | `MIT` |
| async-trait | 0.1.92 | `MIT OR Apache-2.0` |
| atomic-waker | 1.1.2 | `Apache-2.0 OR MIT` |
| auto_generate_cdp | 0.4.6 | `license-file: LICENSE.txt` |
| autocfg | 1.5.1 | `Apache-2.0 OR MIT` |
| base64 | 0.22.1 | `MIT OR Apache-2.0` |
| base64 | 0.23.1 | `MIT OR Apache-2.0` |
| bitflags | 2.13.1 | `MIT OR Apache-2.0` |
| block-buffer | 0.10.4 | `MIT OR Apache-2.0` |
| block-buffer | 0.12.1 | `MIT OR Apache-2.0` |
| brotli | 7.0.0 | `BSD-3-Clause AND MIT` |
| brotli-decompressor | 4.0.3 | `BSD-3-Clause/MIT` |
| bstr | 1.13.1 | `MIT OR Apache-2.0` |
| bumpalo | 3.20.3 | `MIT OR Apache-2.0` |
| byteorder | 1.5.0 | `Unlicense OR MIT` |
| bytes | 1.12.1 | `MIT` |
| castaway | 0.2.4 | `MIT` |
| cc | 1.4.5 | `MIT OR Apache-2.0` |
| cfg-if | 1.0.4 | `MIT OR Apache-2.0` |
| chacha20 | 0.10.2 | `MIT OR Apache-2.0` |
| chrono | 0.4.45 | `MIT OR Apache-2.0` |
| chunked_transfer | 1.5.0 | `MIT OR Apache-2.0` |
| clap | 4.6.6 | `MIT OR Apache-2.0` |
| clap_builder | 4.6.6 | `MIT OR Apache-2.0` |
| clap_derive | 4.6.4 | `MIT OR Apache-2.0` |
| clap_lex | 1.1.0 | `MIT OR Apache-2.0` |
| colorchoice | 1.0.5 | `MIT OR Apache-2.0` |
| compact_str | 0.9.1 | `MIT` |
| const-oid | 0.10.2 | `Apache-2.0 OR MIT` |
| convert_case | 0.10.0 | `MIT` |
| convert_case | 0.8.0 | `MIT` |
| core-foundation | 0.9.4 | `MIT OR Apache-2.0` |
| core-foundation-sys | 0.8.7 | `MIT OR Apache-2.0` |
| cpufeatures | 0.2.17 | `MIT OR Apache-2.0` |
| cpufeatures | 0.3.1 | `MIT OR Apache-2.0` |
| crc32fast | 1.5.1 | `MIT OR Apache-2.0` |
| crossterm | 0.29.0 | `MIT` |
| crossterm_winapi | 0.9.1 | `MIT` |
| crypto-common | 0.1.7 | `MIT OR Apache-2.0` |
| crypto-common | 0.2.2 | `MIT OR Apache-2.0` |
| darling | 0.20.11 | `MIT` |
| darling_core | 0.20.11 | `MIT` |
| darling_macro | 0.20.11 | `MIT` |
| dary_heap | 0.3.9 | `MIT OR Apache-2.0` |
| data-encoding | 2.11.1 | `MIT` |
| deranged | 0.5.8 | `MIT OR Apache-2.0` |
| derive_builder | 0.20.2 | `MIT OR Apache-2.0` |
| derive_builder_core | 0.20.2 | `MIT OR Apache-2.0` |
| derive_builder_macro | 0.20.2 | `MIT OR Apache-2.0` |
| derive_more | 2.1.1 | `MIT` |
| derive_more-impl | 2.1.1 | `MIT` |
| digest | 0.10.7 | `MIT OR Apache-2.0` |
| digest | 0.11.3 | `MIT OR Apache-2.0` |
| dirs | 6.0.0 | `MIT OR Apache-2.0` |
| dirs-sys | 0.5.0 | `MIT OR Apache-2.0` |
| displaydoc | 0.2.7 | `MIT OR Apache-2.0` |
| document-features | 0.2.12 | `MIT OR Apache-2.0` |
| either | 1.18.0 | `MIT OR Apache-2.0` |
| env_logger | 0.10.2 | `MIT OR Apache-2.0` |
| equivalent | 1.0.2 | `Apache-2.0 OR MIT` |
| errno | 0.3.14 | `MIT OR Apache-2.0` |
| fallible-iterator | 0.3.0 | `MIT/Apache-2.0` |
| fallible-streaming-iterator | 0.1.9 | `MIT/Apache-2.0` |
| fastrand | 2.5.0 | `Apache-2.0 OR MIT` |
| find-msvc-tools | 0.1.12 | `MIT OR Apache-2.0` |
| flate2 | 1.1.10 | `MIT OR Apache-2.0` |
| fnv | 1.0.7 | `Apache-2.0 / MIT` |
| foldhash | 0.2.0 | `Zlib` |
| form_urlencoded | 1.2.2 | `MIT OR Apache-2.0` |
| futures | 0.3.34 | `MIT OR Apache-2.0` |
| futures-channel | 0.3.34 | `MIT OR Apache-2.0` |
| futures-core | 0.3.34 | `MIT OR Apache-2.0` |
| futures-executor | 0.3.34 | `MIT OR Apache-2.0` |
| futures-io | 0.3.34 | `MIT OR Apache-2.0` |
| futures-macro | 0.3.34 | `MIT OR Apache-2.0` |
| futures-sink | 0.3.34 | `MIT OR Apache-2.0` |
| futures-task | 0.3.34 | `MIT OR Apache-2.0` |
| futures-util | 0.3.34 | `MIT OR Apache-2.0` |
| generic-array | 0.14.7 | `MIT` |
| getrandom | 0.2.17 | `MIT OR Apache-2.0` |
| getrandom | 0.3.4 | `MIT OR Apache-2.0` |
| getrandom | 0.4.3 | `MIT OR Apache-2.0` |
| globset | 0.4.19 | `Unlicense OR MIT` |
| h2 | 0.4.19 | `MIT` |
| hashbrown | 0.14.5 | `MIT OR Apache-2.0` |
| hashbrown | 0.16.1 | `MIT OR Apache-2.0` |
| hashbrown | 0.17.1 | `MIT OR Apache-2.0` |
| hashlink | 0.9.1 | `MIT OR Apache-2.0` |
| headless_chrome | 1.0.22 | `MIT` |
| heck | 0.5.0 | `MIT OR Apache-2.0` |
| hermit-abi | 0.5.3 | `MIT OR Apache-2.0` |
| hex | 0.4.3 | `MIT OR Apache-2.0` |
| hpack | 0.3.0 | `MIT` |
| http | 1.5.0 | `MIT OR Apache-2.0` |
| http-body | 1.1.0 | `MIT` |
| http-body-util | 0.1.5 | `MIT` |
| httparse | 1.10.1 | `MIT OR Apache-2.0` |
| httpdate | 1.0.3 | `MIT OR Apache-2.0` |
| humantime | 2.4.0 | `MIT OR Apache-2.0` |
| hybrid-array | 0.4.14 | `MIT OR Apache-2.0` |
| hyper | 1.11.1 | `MIT` |
| hyper-util | 0.1.20 | `MIT` |
| iana-time-zone | 0.1.65 | `MIT OR Apache-2.0` |
| iana-time-zone-haiku | 0.1.2 | `MIT OR Apache-2.0` |
| icu_collections | 2.2.0 | `Unicode-3.0` |
| icu_locale_core | 2.2.0 | `Unicode-3.0` |
| icu_normalizer | 2.2.0 | `Unicode-3.0` |
| icu_normalizer_data | 2.2.0 | `Unicode-3.0` |
| icu_properties | 2.2.0 | `Unicode-3.0` |
| icu_properties_data | 2.2.0 | `Unicode-3.0` |
| icu_provider | 2.2.0 | `Unicode-3.0` |
| id-arena | 2.3.0 | `MIT/Apache-2.0` |
| ident_case | 1.0.1 | `MIT/Apache-2.0` |
| idna | 1.1.0 | `MIT OR Apache-2.0` |
| idna_adapter | 1.2.2 | `Apache-2.0 OR MIT` |
| include-flate | 0.3.4 | `Apache-2.0` |
| include-flate-codegen | 0.3.4 | `Apache-2.0` |
| include-flate-compress | 0.3.4 | `Apache-2.0` |
| indexmap | 2.14.2 | `Apache-2.0 OR MIT` |
| indoc | 2.0.7 | `MIT OR Apache-2.0` |
| instability | 0.3.10 | `MIT` |
| ipnet | 2.12.1 | `MIT OR Apache-2.0` |
| is-terminal | 0.4.17 | `MIT` |
| is_terminal_polyfill | 1.70.2 | `MIT OR Apache-2.0` |
| itertools | 0.14.0 | `MIT OR Apache-2.0` |
| itoa | 1.0.18 | `MIT OR Apache-2.0` |
| jobserver | 0.1.35 | `MIT OR Apache-2.0` |
| js-sys | 0.3.105 | `MIT OR Apache-2.0` |
| kasuari | 0.4.12 | `MIT OR Apache-2.0` |
| leb128fmt | 0.1.0 | `MIT OR Apache-2.0` |
| libc | 0.2.189 | `MIT OR Apache-2.0` |
| libflate | 2.3.1 | `MIT` |
| libflate_lz77 | 2.3.0 | `MIT` |
| libredox | 0.1.23 | `MIT` |
| libsqlite3-sys | 0.30.1 | `MIT` |
| line-clipping | 0.3.8 | `MIT OR Apache-2.0` |
| linux-raw-sys | 0.12.1 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| litemap | 0.8.3 | `Unicode-3.0` |
| litrs | 1.0.0 | `MIT OR Apache-2.0` |
| lock_api | 0.4.14 | `MIT OR Apache-2.0` |
| log | 0.3.9 | `MIT/Apache-2.0` |
| log | 0.4.34 | `MIT OR Apache-2.0` |
| lru | 0.16.4 | `MIT` |
| macro-string | 0.2.0 | `MIT OR Apache-2.0` |
| memchr | 2.8.3 | `Unlicense OR MIT` |
| mime | 0.3.17 | `MIT OR Apache-2.0` |
| mime_guess | 2.0.5 | `MIT` |
| miniz_oxide | 0.9.1 | `MIT OR Zlib OR Apache-2.0` |
| mio | 1.2.3 | `MIT` |
| no_std_io2 | 0.9.4 | `Apache-2.0 OR MIT` |
| ntapi | 0.4.3 | `Apache-2.0 OR MIT` |
| num-conv | 0.1.0 | `MIT OR Apache-2.0` |
| num-traits | 0.2.19 | `MIT OR Apache-2.0` |
| num_cpus | 1.17.0 | `MIT OR Apache-2.0` |
| num_threads | 0.1.7 | `MIT OR Apache-2.0` |
| objc2-core-foundation | 0.3.2 | `Zlib OR Apache-2.0 OR MIT` |
| objc2-io-kit | 0.3.2 | `Zlib OR Apache-2.0 OR MIT` |
| once_cell | 1.21.4 | `MIT OR Apache-2.0` |
| once_cell_polyfill | 1.70.2 | `MIT OR Apache-2.0` |
| option-ext | 0.2.0 | `MPL-2.0` |
| parking_lot | 0.12.5 | `MIT OR Apache-2.0` |
| parking_lot_core | 0.9.12 | `MIT OR Apache-2.0` |
| percent-encoding | 2.3.2 | `MIT OR Apache-2.0` |
| pin-project-lite | 0.2.17 | `Apache-2.0 OR MIT` |
| pkg-config | 0.3.34 | `MIT OR Apache-2.0` |
| portable-atomic | 1.15.0 | `Apache-2.0 OR MIT` |
| potential_utf | 0.1.6 | `Unicode-3.0` |
| powerfmt | 0.2.0 | `MIT OR Apache-2.0` |
| ppv-lite86 | 0.2.21 | `MIT OR Apache-2.0` |
| prettyplease | 0.2.37 | `MIT OR Apache-2.0` |
| proc-macro-error-attr3 | 3.1.1 | `MIT OR Apache-2.0` |
| proc-macro-error3 | 3.1.1 | `MIT OR Apache-2.0` |
| proc-macro2 | 1.0.107 | `MIT OR Apache-2.0` |
| qrcode | 0.14.1 | `MIT OR Apache-2.0` |
| quote | 1.0.47 | `MIT OR Apache-2.0` |
| r-efi | 5.3.0 | `MIT OR Apache-2.0 OR LGPL-2.1-or-later` |
| r-efi | 6.0.0 | `MIT OR Apache-2.0 OR LGPL-2.1-or-later` |
| rand | 0.10.2 | `MIT OR Apache-2.0` |
| rand | 0.9.5 | `MIT OR Apache-2.0` |
| rand_chacha | 0.9.0 | `MIT OR Apache-2.0` |
| rand_core | 0.10.1 | `MIT OR Apache-2.0` |
| rand_core | 0.9.5 | `MIT OR Apache-2.0` |
| ratatui | 0.30.0 | `MIT` |
| ratatui-core | 0.1.0 | `MIT` |
| ratatui-crossterm | 0.1.0 | `MIT` |
| ratatui-widgets | 0.3.0 | `MIT` |
| redox_syscall | 0.5.18 | `MIT` |
| redox_users | 0.5.2 | `MIT` |
| regex | 1.13.1 | `MIT OR Apache-2.0` |
| regex-automata | 0.4.18 | `MIT OR Apache-2.0` |
| regex-syntax | 0.8.11 | `MIT OR Apache-2.0` |
| ring | 0.17.14 | `Apache-2.0 AND ISC` |
| rle-decode-fast | 1.0.3 | `MIT OR Apache-2.0` |
| rusqlite | 0.32.1 | `MIT` |
| rust-embed | 8.12.0 | `MIT` |
| rust-embed-impl | 8.12.0 | `MIT` |
| rust-embed-utils | 8.12.0 | `MIT` |
| rustc_version | 0.4.1 | `MIT OR Apache-2.0` |
| rustix | 1.1.4 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| rustls | 0.23.43 | `Apache-2.0 OR ISC OR MIT` |
| rustls-pki-types | 1.15.1 | `MIT OR Apache-2.0` |
| rustls-webpki | 0.103.15 | `ISC` |
| rustversion | 1.0.23 | `MIT OR Apache-2.0` |
| ryu | 1.0.23 | `Apache-2.0 OR BSL-1.0` |
| same-file | 1.0.6 | `Unlicense/MIT` |
| scopeguard | 1.2.0 | `MIT OR Apache-2.0` |
| semver | 1.0.28 | `MIT OR Apache-2.0` |
| serde | 1.0.229 | `MIT OR Apache-2.0` |
| serde_core | 1.0.229 | `MIT OR Apache-2.0` |
| serde_derive | 1.0.229 | `MIT OR Apache-2.0` |
| serde_json | 1.0.151 | `MIT OR Apache-2.0` |
| sha1 | 0.10.7 | `MIT OR Apache-2.0` |
| sha1 | 0.11.0 | `MIT OR Apache-2.0` |
| sha2 | 0.10.9 | `MIT OR Apache-2.0` |
| sha2 | 0.11.0 | `MIT OR Apache-2.0` |
| shlex | 2.0.1 | `MIT OR Apache-2.0` |
| signal-hook | 0.3.18 | `Apache-2.0/MIT` |
| signal-hook-mio | 0.2.5 | `MIT OR Apache-2.0` |
| signal-hook-registry | 1.4.8 | `MIT OR Apache-2.0` |
| simd-adler32 | 0.3.10 | `MIT` |
| slab | 0.4.12 | `MIT` |
| smallvec | 1.16.0 | `MIT OR Apache-2.0` |
| socket2 | 0.6.5 | `MIT OR Apache-2.0` |
| socks | 0.3.4 | `MIT/Apache-2.0` |
| stable_deref_trait | 1.2.1 | `MIT OR Apache-2.0` |
| static_assertions | 1.1.0 | `MIT OR Apache-2.0` |
| strsim | 0.11.1 | `MIT` |
| strum | 0.27.2 | `MIT` |
| strum_macros | 0.27.2 | `MIT` |
| subtle | 2.6.1 | `BSD-3-Clause` |
| syn | 2.0.119 | `MIT OR Apache-2.0` |
| syn | 3.0.5 | `MIT OR Apache-2.0` |
| synstructure | 0.13.2 | `MIT` |
| sysinfo | 0.36.1 | `MIT` |
| system-configuration | 0.7.0 | `MIT OR Apache-2.0` |
| system-configuration-sys | 0.6.0 | `MIT OR Apache-2.0` |
| tempfile | 3.27.0 | `MIT OR Apache-2.0` |
| termcolor | 1.4.1 | `Unlicense OR MIT` |
| thiserror | 2.0.20 | `MIT OR Apache-2.0` |
| thiserror-impl | 2.0.20 | `MIT OR Apache-2.0` |
| time | 0.3.45 | `MIT OR Apache-2.0` |
| time-core | 0.1.7 | `MIT OR Apache-2.0` |
| tinystr | 0.8.4 | `Unicode-3.0` |
| tokio | 1.53.1 | `MIT` |
| tokio-macros | 2.7.2 | `MIT` |
| tokio-rustls | 0.26.5 | `MIT OR Apache-2.0` |
| tokio-tungstenite | 0.30.0 | `MIT` |
| tokio-util | 0.7.19 | `MIT` |
| tower-layer | 0.3.3 | `MIT` |
| tower-service | 0.3.3 | `MIT` |
| tracing | 0.1.44 | `MIT` |
| tracing-core | 0.1.36 | `MIT` |
| try-lock | 0.2.5 | `MIT` |
| tungstenite | 0.29.0 | `MIT OR Apache-2.0` |
| tungstenite | 0.30.0 | `MIT OR Apache-2.0` |
| typenum | 1.20.1 | `MIT OR Apache-2.0` |
| unicase | 2.9.0 | `MIT OR Apache-2.0` |
| unicode-ident | 1.0.24 | `(MIT OR Apache-2.0) AND Unicode-3.0` |
| unicode-segmentation | 1.13.3 | `MIT OR Apache-2.0` |
| unicode-truncate | 2.0.1 | `MIT OR Apache-2.0` |
| unicode-width | 0.2.2 | `MIT OR Apache-2.0` |
| unicode-xid | 0.2.6 | `MIT OR Apache-2.0` |
| untrusted | 0.9.0 | `ISC` |
| ureq | 3.4.0 | `MIT OR Apache-2.0` |
| ureq-proto | 0.6.1 | `MIT OR Apache-2.0` |
| url | 2.5.8 | `MIT OR Apache-2.0` |
| utf8-zero | 0.8.1 | `MIT OR Apache-2.0` |
| utf8_iter | 1.0.4 | `Apache-2.0 OR MIT` |
| utf8parse | 0.2.2 | `Apache-2.0 OR MIT` |
| uuid | 1.26.0 | `Apache-2.0 OR MIT` |
| vcpkg | 0.2.15 | `MIT/Apache-2.0` |
| version_check | 0.9.5 | `MIT/Apache-2.0` |
| walkdir | 2.5.0 | `Unlicense/MIT` |
| want | 0.3.1 | `MIT` |
| wasi | 0.11.1+wasi-snapshot-preview1 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wasip2 | 1.0.4+wasi-0.2.12 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wasm-bindgen | 0.2.128 | `MIT OR Apache-2.0` |
| wasm-bindgen-macro | 0.2.128 | `MIT OR Apache-2.0` |
| wasm-bindgen-macro-support | 0.2.128 | `MIT OR Apache-2.0` |
| wasm-bindgen-shared | 0.2.128 | `MIT OR Apache-2.0` |
| wasm-encoder | 0.247.0 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wasm-metadata | 0.247.0 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wasmparser | 0.247.0 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| webpki-roots | 0.26.11 | `CDLA-Permissive-2.0` |
| webpki-roots | 1.0.9 | `CDLA-Permissive-2.0` |
| which | 8.0.6 | `MIT` |
| winapi | 0.3.9 | `MIT/Apache-2.0` |
| winapi-i686-pc-windows-gnu | 0.4.0 | `MIT/Apache-2.0` |
| winapi-util | 0.1.11 | `Unlicense OR MIT` |
| winapi-x86_64-pc-windows-gnu | 0.4.0 | `MIT/Apache-2.0` |
| windows | 0.61.3 | `MIT OR Apache-2.0` |
| windows-collections | 0.2.0 | `MIT OR Apache-2.0` |
| windows-core | 0.61.2 | `MIT OR Apache-2.0` |
| windows-core | 0.62.2 | `MIT OR Apache-2.0` |
| windows-future | 0.2.1 | `MIT OR Apache-2.0` |
| windows-implement | 0.60.2 | `MIT OR Apache-2.0` |
| windows-interface | 0.59.3 | `MIT OR Apache-2.0` |
| windows-link | 0.1.3 | `MIT OR Apache-2.0` |
| windows-link | 0.2.1 | `MIT OR Apache-2.0` |
| windows-numerics | 0.2.0 | `MIT OR Apache-2.0` |
| windows-registry | 0.6.1 | `MIT OR Apache-2.0` |
| windows-result | 0.3.4 | `MIT OR Apache-2.0` |
| windows-result | 0.4.1 | `MIT OR Apache-2.0` |
| windows-strings | 0.4.2 | `MIT OR Apache-2.0` |
| windows-strings | 0.5.1 | `MIT OR Apache-2.0` |
| windows-sys | 0.52.0 | `MIT OR Apache-2.0` |
| windows-sys | 0.61.2 | `MIT OR Apache-2.0` |
| windows-targets | 0.52.6 | `MIT OR Apache-2.0` |
| windows-threading | 0.1.0 | `MIT OR Apache-2.0` |
| windows_aarch64_gnullvm | 0.52.6 | `MIT OR Apache-2.0` |
| windows_aarch64_msvc | 0.52.6 | `MIT OR Apache-2.0` |
| windows_i686_gnu | 0.52.6 | `MIT OR Apache-2.0` |
| windows_i686_gnullvm | 0.52.6 | `MIT OR Apache-2.0` |
| windows_i686_msvc | 0.52.6 | `MIT OR Apache-2.0` |
| windows_x86_64_gnu | 0.52.6 | `MIT OR Apache-2.0` |
| windows_x86_64_gnullvm | 0.52.6 | `MIT OR Apache-2.0` |
| windows_x86_64_msvc | 0.52.6 | `MIT OR Apache-2.0` |
| winreg | 0.56.0 | `MIT` |
| wit-bindgen | 0.57.1 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wit-bindgen-core | 0.57.1 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wit-bindgen-rust | 0.57.1 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wit-bindgen-rust-macro | 0.57.1 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wit-component | 0.247.0 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| wit-parser | 0.247.0 | `Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT` |
| writeable | 0.6.4 | `Unicode-3.0` |
| yoke | 0.8.3 | `Unicode-3.0` |
| yoke-derive | 0.8.2 | `Unicode-3.0` |
| zerocopy | 0.8.56 | `BSD-2-Clause OR Apache-2.0 OR MIT` |
| zerocopy-derive | 0.8.56 | `BSD-2-Clause OR Apache-2.0 OR MIT` |
| zerofrom | 0.1.8 | `Unicode-3.0` |
| zerofrom-derive | 0.1.7 | `Unicode-3.0` |
| zeroize | 1.9.0 | `Apache-2.0 OR MIT` |
| zerotrie | 0.2.5 | `Unicode-3.0` |
| zerovec | 0.11.8 | `Unicode-3.0` |
| zerovec-derive | 0.11.6 | `Unicode-3.0` |
| zlib-rs | 0.6.7 | `Zlib` |
| zmij | 1.0.23 | `MIT` |
| zstd | 0.13.3 | `MIT` |
| zstd-safe | 7.3.0 | `BSD-3-Clause` |
| zstd-sys | 2.1.0+zstd.1.5.7 | `BSD-3-Clause` |
