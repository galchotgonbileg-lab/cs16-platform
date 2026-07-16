#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE="${ROOT}/docker/docker-compose.yml"

echo "[1/6] Stop containers..."
docker compose -f "${COMPOSE}" down -v --remove-orphans || true

echo "[2/6] Remove images..."
docker compose -f "${COMPOSE}" down --rmi local || true

echo "[3/6] Remove server..."
rm -rf "${ROOT}/server"

echo "[4/6] Remove backups..."
rm -rf "${ROOT}/backups"

echo "[5/6] Remove temporary files..."
find "${ROOT}" -name "*.log" -delete
find "${ROOT}" -name "*.pid" -delete

echo "[6/6] Done."

echo
echo "CS16 Platform removed."