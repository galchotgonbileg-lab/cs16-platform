#!/usr/bin/env bash
set -euo pipefail

STEAMCMD_DIR=${STEAMCMD_DIR:-/opt/steamcmd}
SERVER_DIR=${SERVER_DIR:-/opt/cs16}

echo "[+] Installing HLDS..."

${STEAMCMD_DIR}/steamcmd.sh \
    +force_install_dir "${SERVER_DIR}" \
    +login anonymous \
    +app_update 90 validate \
    +quit

echo "[+] Installing ReHLDS..."

mkdir -p /tmp/rehlds
cd /tmp/rehlds

wget -q -O rehlds.tar.gz \
https://github.com/rehlds/ReHLDS/releases/latest/download/rehlds-bin-linux-amd64.tar.gz

tar -xzf rehlds.tar.gz

cp -rf bin/linux/* "${SERVER_DIR}/"

echo "[+] Installing Metamod-r..."

mkdir -p /tmp/metamod
cd /tmp/metamod

wget -q -O metamod.tar.gz \
https://github.com/theAsmodai/metamod-r/releases/latest/download/mmsource-1.11.0-git1144-linux.tar.gz

tar -xzf metamod.tar.gz

cp -rf addons "${SERVER_DIR}/"

echo "[+] Installing ReGameDLL..."

mkdir -p /tmp/regamedll
cd /tmp/regamedll

wget -q -O regamedll.tar.gz \
https://github.com/s1lentq/ReGameDLL_CS/releases/latest/download/regamedll-bin-5.28.0.756.tar.gz

tar -xzf regamedll.tar.gz

cp -rf addons "${SERVER_DIR}/"

echo "[+] Installing AMX Mod X..."

mkdir -p /tmp/amxx
cd /tmp/amxx

wget -q -O amxx.tar.gz \
https://www.amxmodx.org/amxxdrop/amxmodx-1.10.0-git5468-base-linux.tar.gz

tar -xzf amxx.tar.gz

cp -rf addons "${SERVER_DIR}/"

echo "[+] Installation completed."