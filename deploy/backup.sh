#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DATE=$(date +"%Y%m%d-%H%M%S")
BACKUP_DIR="${ROOT}/backups/${DATE}"

mkdir -p "${BACKUP_DIR}"

echo "[1/5] Backup server..."
cp -a "${ROOT}/server" "${BACKUP_DIR}/"

echo "[2/5] Backup plugins..."
cp -a "${ROOT}/plugins" "${BACKUP_DIR}/"

echo "[3/5] Backup docker..."
cp -a "${ROOT}/docker" "${BACKUP_DIR}/"

echo "[4/5] Backup docs..."
cp -a "${ROOT}/docs" "${BACKUP_DIR}/" 2>/dev/null || true

echo "[5/5] Compress..."

tar -czf "${ROOT}/backups/${DATE}.tar.gz" \
    -C "${ROOT}/backups" "${DATE}"

rm -rf "${BACKUP_DIR}"

echo
echo "Backup: ${ROOT}/backups/${DATE}.tar.gz"