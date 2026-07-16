#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

HLDS_DIR="${ROOT}/server/hlds"

GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
NC="\033[0m"

ok() {
    echo -e "${GREEN}[ OK ]${NC} $1"
}

fail() {
    echo -e "${RED}[FAIL]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo "========================================="
echo " CS16 Platform Verification"
echo "========================================="

command -v docker >/dev/null \
    && ok "Docker installed" \
    || fail "Docker missing"

docker compose version >/dev/null 2>&1 \
    && ok "Docker Compose installed" \
    || fail "Docker Compose missing"

docker ps --format '{{.Names}}' | grep -q '^cs16-server$' \
    && ok "Container running" \
    || fail "Container not running"

[ -f "${HLDS_DIR}/hlds_run" ] \
    && ok "HLDS installed" \
    || fail "HLDS missing"

[ -f "${HLDS_DIR}/engine_i486.so" ] \
    && ok "ReHLDS installed" \
    || warn "ReHLDS missing"

[ -f "${HLDS_DIR}/cstrike/dlls/cs.so" ] \
    && ok "ReGameDLL installed" \
    || warn "ReGameDLL missing"

[ -f "${HLDS_DIR}/cstrike/addons/metamod/metamod.so" ] \
    && ok "Metamod-R installed" \
    || warn "Metamod-R missing"

[ -f "${HLDS_DIR}/cstrike/addons/amxmodx/configs/plugins.ini" ] \
    && ok "AMX Mod X installed" \
    || warn "AMX Mod X missing"

ss -lun | grep -q ":27015" \
    && ok "UDP 27015 listening" \
    || warn "UDP 27015 not listening"

echo
echo "Verification completed."