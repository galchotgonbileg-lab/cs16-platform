#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HLDS_DIR="${ROOT}/server/hlds"
REHLDS_DIR="${ROOT}/server/rehlds"
TMP_DIR="/tmp/rehlds"

mkdir -p "${REHLDS_DIR}"
rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

echo "[1/5] Detect architecture..."

ARCH=$(uname -m)

case "${ARCH}" in
    x86_64)
        PACKAGE="rehlds-bin-3.14.0.857-linux-amd64.tar.xz"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

echo "[2/5] Download ReHLDS..."

wget -O "${TMP_DIR}/rehlds.tar.xz" \
https://github.com/rehlds/ReHLDS/releases/latest/download/${PACKAGE}

echo "[3/5] Extract..."

tar -xJf "${TMP_DIR}/rehlds.tar.xz" -C "${TMP_DIR}"

echo "[4/5] Install..."

cp -rf "${TMP_DIR}"/* "${REHLDS_DIR}/"

cp -f "${REHLDS_DIR}/bin/linux64/engine_i486.so" \
"${HLDS_DIR}/engine_i486.so"

cp -f "${REHLDS_DIR}/bin/linux64/hlds_linux" \
"${HLDS_DIR}/hlds_linux"

chmod +x "${HLDS_DIR}/hlds_run"
chmod +x "${HLDS_DIR}/hlds_linux"

echo "[5/5] Done"

echo
echo "ReHLDS installed."