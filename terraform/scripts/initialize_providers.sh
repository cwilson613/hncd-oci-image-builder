#!/usr/bin/env bash
set -euo pipefail

# Run from repo/terraform
cd "$(dirname "$0")/.."

# Avoid small /tmp tmpfs
export TMPDIR="${TMPDIR:-/var/tmp}"

LOCK_DIR="artifacts/lock-module"   # tiny module WITH required_providers
MIRROR_DIR="mirror"

# Sanity
[ -f "${LOCK_DIR}/versions.tf" ] || { echo "Missing ${LOCK_DIR}/versions.tf"; exit 1; }

terraform -chdir="${LOCK_DIR}" init -input=false -no-color
terraform -chdir="${LOCK_DIR}" providers lock -platform=linux_amd64

mkdir -p "${MIRROR_DIR}"
terraform -chdir="${LOCK_DIR}" providers mirror "$(pwd)/${MIRROR_DIR}"

# Keep the lock for auditing
cp -f "${LOCK_DIR}/.terraform.lock.hcl" artifacts/.terraform.lock.hcl

echo "OK: mirrored to ${MIRROR_DIR}/"
