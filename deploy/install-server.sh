#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SERVER_DIR="${ROOT}/server"
STEAMCMD_DIR="${SERVER_DIR}/steamcmd"
HLDS_DIR="${SERVER_DIR}/hlds"
REHLDS_DIR="${SERVER_DIR}/rehlds"
REGAMEDLL_DIR="${SERVER_DIR}/regamedll"
METAMOD_DIR="${SERVER_DIR}/metamod-r"
AMXX_DIR="${SERVER_DIR}/amxmodx"

mkdir -p \
    "${STEAMCMD_DIR}" \
    "${HLDS_DIR}" \
    "${REHLDS_DIR}" \
    "${REGAMEDLL_DIR}" \
    "${METAMOD_DIR}" \
    "${AMXX_DIR}"

echo "[1/6] Install SteamCMD..."

if [ ! -f "${STEAMCMD_DIR}/steamcmd.sh" ]; then
    wget -qO /tmp/steamcmd_linux.tar.gz \
        https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz

    tar -xzf /tmp/steamcmd_linux.tar.gz -C "${STEAMCMD_DIR}"
    rm -f /tmp/steamcmd_linux.tar.gz
fi

echo "[2/6] Install HLDS..."

"${STEAMCMD_DIR}/steamcmd.sh" \
    +force_install_dir "${HLDS_DIR}" \
    +login anonymous \
    +app_update 90 validate \
    +quit

echo "[3/6] Download ReHLDS..."
echo "TODO"

echo "[4/6] Download ReGameDLL..."
echo "TODO"

echo "[5/6] Download Metamod-R..."
echo "TODO"

echo "[6/6] Download AMX Mod X..."
echo "TODO"

echo
echo "Done."
echo
echo "SteamCMD : ${STEAMCMD_DIR}"
echo "HLDS     : ${HLDS_DIR}"
echo "ReHLDS   : ${REHLDS_DIR}"
echo "ReGameDLL: ${REGAMEDLL_DIR}"
echo "Metamod  : ${METAMOD_DIR}"
echo "AMXX     : ${AMXX_DIR}"