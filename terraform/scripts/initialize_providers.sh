#!/usr/bin/env bash
set -euo pipefail

# Run from repo/terraform (one level up from scripts/)
cd "$(dirname "$0")/.."

# Use disk-backed temp (your /tmp is tiny tmpfs). No extra dirs needed.
export TMPDIR="${TMPDIR:-/var/tmp}"

MIRROR_DIR="./mirror"

# Assumes required_providers are already defined in the current directory's .tf files.
terraform init -input=false -no-color

# Lock only the arch you asked for
terraform providers lock -platform=linux_amd64

# Mirror exact provider zips into the build context
mkdir -p "$MIRROR_DIR"
terraform providers mirror "$MIRROR_DIR"

echo "OK: providers mirrored to $MIRROR_DIR/"
