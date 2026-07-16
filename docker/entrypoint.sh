#!/usr/bin/env bash
set -euo pipefail

SERVER_DIR=${SERVER_DIR:-/opt/cs16}

MODE=${MODE:-dm}
PORT=${PORT:-27015}
MAP=${MAP:-de_dust2}
MAXPLAYERS=${MAXPLAYERS:-32}
HOSTNAME=${HOSTNAME:-CS16 Platform}

CFG="server.cfg"

case "$MODE" in
    dm)
        CFG="dm.cfg"
        ;;
    competitive)
        CFG="competitive.cfg"
        ;;
    arena)
        CFG="arena.cfg"
        ;;
    gungame)
        CFG="gungame.cfg"
        ;;
    zombie)
        CFG="zombie.cfg"
        ;;
    jailbreak)
        CFG="jailbreak.cfg"
        ;;
    surf)
        CFG="surf.cfg"
        ;;
    bhop)
        CFG="bhop.cfg"
        ;;
esac

cd "${SERVER_DIR}"

exec ./hlds_run \
    -game cstrike \
    +ip 0.0.0.0 \
    +port "${PORT}" \
    +maxplayers "${MAXPLAYERS}" \
    +map "${MAP}" \
    +hostname "${HOSTNAME}" \
    +exec "${CFG}" \
    -pingboost 2 \
    -insecure \
    -norestart