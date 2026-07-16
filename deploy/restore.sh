#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "  $0 backups/<backup>.tar.gz"
    exit 1
fi

BACKUP="$1"

if [ ! -f "${BACKUP}" ]; then
    echo "Backup not found."
    exit 1
fi

TMP=$(mktemp -d)

echo "[1/6] Stop containers..."
docker compose -f "${ROOT}/docker/docker-compose.yml" down

echo "[2/6] Extract..."
tar -xzf "${BACKUP}" -C "${TMP}"

DIR=$(find "${TMP}" -mindepth 1 -maxdepth 1 -type d | head -n1)

echo "[3/6] Restore server..."
rm -rf "${ROOT}/server"
cp -a "${DIR}/server" "${ROOT}/"

echo "[4/6] Restore plugins..."
rm -rf "${ROOT}/plugins"
cp -a "${DIR}/plugins" "${ROOT}/"

echo "[5/6] Restore docker..."
rm -rf "${ROOT}/docker"
cp -a "${DIR}/docker" "${ROOT}/"

echo "[6/6] Start containers..."
docker compose -f "${ROOT}/docker/docker-compose.yml" up -d

rm -rf "${TMP}"

echo
echo "Restore completed."