#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HLDS_DIR="${ROOT}/server/hlds"
AMXX_DIR="${ROOT}/server/amxmodx"
TMP_DIR="/tmp/amxx"

mkdir -p "${AMXX_DIR}"
rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

echo "[1/5] Detect architecture..."

ARCH=$(uname -m)

case "${ARCH}" in
    x86_64)
        PACKAGE="amxmodx-1.10.0-git5467-base-linux.tar.gz"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

echo "[2/5] Download AMX Mod X..."

wget -O "${TMP_DIR}/amxx.tar.gz" \
https://www.amxmodx.org/amxxdrop/${PACKAGE}

echo "[3/5] Extract..."

tar -xzf "${TMP_DIR}/amxx.tar.gz" -C "${TMP_DIR}"

echo "[4/5] Install..."

cp -rf \
"${TMP_DIR}/addons/amxmodx" \
"${HLDS_DIR}/cstrike/addons/"

mkdir -p "${HLDS_DIR}/cstrike/addons/metamod"

cat > "${HLDS_DIR}/cstrike/addons/metamod/plugins.ini" <<EOF
linux addons/amxmodx/dlls/amxmodx_mm_i386.so
EOF

echo "[5/5] Done"

echo
echo "AMX Mod X installed."