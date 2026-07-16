#!/usr/bin/env bash
set -Eeuo pipefail

VERSION="${1:-}"

if [ -z "${VERSION}" ]; then
    echo "Usage: ./scripts/release.sh <version>"
    exit 1
fi

echo "[1/7] Verify..."
./deploy/verify.sh

echo "[2/7] Git Status..."
git diff --quiet
git diff --cached --quiet

echo "[3/7] Create Tag..."
git tag -a "${VERSION}" -m "Release ${VERSION}"

echo "[4/7] Push..."
git push origin main
git push origin "${VERSION}"

echo "[5/7] Docker Build..."
docker compose -f docker/docker-compose.yml build

echo "[6/7] Docker Restart..."
docker compose -f docker/docker-compose.yml up -d

echo "[7/7] Done."

echo "Release ${VERSION} completed."