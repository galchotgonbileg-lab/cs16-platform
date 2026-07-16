#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SERVER_DIR="${ROOT}/hlds"

cd "${SERVER_DIR}"

exec ./hlds_run \
    -game cstrike \
    -console \
    -insecure \
    +ip 0.0.0.0 \
    +port 27015 \
    +maxplayers 32 \
    +map de_dust2