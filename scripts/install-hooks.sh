#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${ROOT}"

git config --local core.hooksPath .githooks
chmod +x .githooks/pre-commit scripts/install-hooks.sh

echo "Git hooks path configured: .githooks"