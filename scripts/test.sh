#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${ROOT}"

echo "[1/8] Docker..."
docker version >/dev/null

echo "[2/8] Compose..."
docker compose version >/dev/null

echo "[3/8] Build..."
docker compose -f docker/docker-compose.yml build

echo "[4/8] Start..."
docker compose -f docker/docker-compose.yml up -d

echo "[5/8] Verify..."
./deploy/verify.sh

echo "[6/8] Container..."
docker ps

echo "[7/8] Logs..."
docker compose -f docker/docker-compose.yml logs --tail=50

echo "[8/8] Success."

echo
echo "All tests passed."