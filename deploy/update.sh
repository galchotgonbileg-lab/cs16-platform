#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${ROOT}"

echo "[1/6] Git Pull..."
git pull --rebase

echo "[2/6] Docker Build..."
docker compose -f docker/docker-compose.yml build

echo "[3/6] Docker Restart..."
docker compose -f docker/docker-compose.yml up -d

echo "[4/6] Cleanup..."
docker image prune -f

echo "[5/6] Verify..."
./deploy/verify.sh

echo "[6/6] Done."