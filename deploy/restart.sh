#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[1/4] Stop..."
docker compose -f "${ROOT}/docker/docker-compose.yml" down

echo "[2/4] Build..."
docker compose -f "${ROOT}/docker/docker-compose.yml" build

echo "[3/4] Start..."
docker compose -f "${ROOT}/docker/docker-compose.yml" up -d

echo "[4/4] Status..."
docker compose -f "${ROOT}/docker/docker-compose.yml" ps