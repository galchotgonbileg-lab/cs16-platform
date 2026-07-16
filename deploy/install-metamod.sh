#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HLDS_DIR="${ROOT}/server/hlds"
METAMOD_DIR="${ROOT}/server/metamod-r"
TMP_DIR="/tmp/metamod"

mkdir -p "${METAMOD_DIR}"
rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

echo "[1/5] Detect architecture..."

ARCH=$(uname -m)

case "${ARCH}" in
    x86_64)
        PACKAGE="mmsource-1.11.0-git1166-linux.tar.gz"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

echo "[2/5] Download Metamod-R..."

wget -O "${TMP_DIR}/metamod.tar.gz" \
https://github.com/theAsmodai/metamod-r/releases/latest/download/${PACKAGE}

echo "[3/5] Extract..."

tar -xzf "${TMP_DIR}/metamod.tar.gz" -C "${TMP_DIR}"

echo "[4/5] Install..."

mkdir -p "${HLDS_DIR}/cstrike/addons"

cp -rf \
"${TMP_DIR}/addons/metamod" \
"${HLDS_DIR}/cstrike/addons/"

echo "linux addons/metamod/metamod.so" \
> "${HLDS_DIR}/cstrike/liblist.gam"

echo "[5/5] Done"

echo
echo "Metamod-R installed."