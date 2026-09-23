#!/usr/bin/env bash
# Reassemble and verify the AgentSight RHEL 9 bundle from its parts.
# Usage: ./v1.0.31/reassemble.sh [output-dir]   (default: ./agentsight-bundle in the current directory)
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="$(realpath -m "${1:-$PWD/agentsight-bundle}")"
name="agentsight-v1.0.31-rhel9-bundle.tar.gz"

need_kb=$(( $(cat "$here/$name".part-* | wc -c) / 1024 + 10240 ))
mkdir -p "$out"
avail_kb="$(df -Pk "$out" | awk 'NR==2 {print $4}')"
if [ "$avail_kb" -lt "$need_kb" ]; then
    echo "error: only $((avail_kb / 1024)) MB free in $out, need $((need_kb / 1024)) MB" >&2
    echo "       pass a directory on a bigger filesystem: $0 /path/with/space" >&2
    exit 1
fi

echo "==> verifying parts"
( cd "$here" && sha256sum -c --quiet parts.sha256 )
echo "==> reassembling $out/$name"
cat "$here/$name".part-* > "$out/$name"
cp "$here/$name.sha256" "$out/$name.sha256"
echo "==> verifying bundle"
( cd "$out" && sha256sum -c "$name.sha256" )
echo "done: $out/$name"
