#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo
echo "======================================"
echo " CS16 Platform Bootstrap"
echo "======================================"
echo

cd "${ROOT}"

chmod +x deploy/*.sh

echo "[1/7] Docker..."
./deploy/install-docker.sh

echo "[2/7] SteamCMD + HLDS..."
./deploy/install-server.sh

echo "[3/7] ReHLDS..."
./deploy/install-rehlds.sh

echo "[4/7] ReGameDLL..."
./deploy/install-regamedll.sh

echo "[5/7] Metamod-R..."
./deploy/install-metamod.sh

echo "[6/7] AMX Mod X..."
./deploy/install-amxx.sh

echo "[7/7] Verify..."
./deploy/verify.sh

echo
echo "======================================"
echo " Bootstrap Complete"
echo "======================================"