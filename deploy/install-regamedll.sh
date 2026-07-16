#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HLDS_DIR="${ROOT}/server/hlds"
REGAMEDLL_DIR="${ROOT}/server/regamedll"
TMP_DIR="/tmp/regamedll"

mkdir -p "${REGAMEDLL_DIR}"
rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

echo "[1/5] Detect architecture..."

ARCH=$(uname -m)

case "${ARCH}" in
    x86_64)
        PACKAGE="regamedll-bin-5.28.0.756-linux-amd64.tar.xz"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

echo "[2/5] Download ReGameDLL..."

wget -O "${TMP_DIR}/regamedll.tar.xz" \
https://github.com/rehlds/ReGameDLL_CS/releases/latest/download/${PACKAGE}

echo "[3/5] Extract..."

tar -xJf "${TMP_DIR}/regamedll.tar.xz" -C "${TMP_DIR}"

echo "[4/5] Install..."

cp -rf "${TMP_DIR}"/* "${REGAMEDLL_DIR}/"

mkdir -p "${HLDS_DIR}/cstrike/dlls"

cp -f \
"${REGAMEDLL_DIR}/bin/linux64/cs.so" \
"${HLDS_DIR}/cstrike/dlls/cs.so"

chmod +x "${HLDS_DIR}/cstrike/dlls/cs.so"

echo "[5/5] Done"

echo
echo "ReGameDLL installed."