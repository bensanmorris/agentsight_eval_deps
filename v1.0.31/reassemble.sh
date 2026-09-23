#!/usr/bin/env bash
# Reassemble and verify the AgentSight RHEL 9 bundle from its parts.
# Usage: ./reassemble.sh [output-dir]   (default: this directory)
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
out="${1:-$here}"
name="agentsight-v1.0.31-rhel9-bundle.tar.gz"
cd "$here"
echo "==> verifying parts"
sha256sum -c --quiet parts.sha256
echo "==> reassembling $out/$name"
mkdir -p "$out"
cat "$name".part-* > "$out/$name"
cp "$name.sha256" "$out/$name.sha256"
echo "==> verifying bundle"
( cd "$out" && sha256sum -c "$name.sha256" )
echo "done: $out/$name"
