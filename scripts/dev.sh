#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${ROOT}"

case "${1:-}" in
    up)
        docker compose -f docker/docker-compose.yml up -d --build
        ;;
    down)
        docker compose -f docker/docker-compose.yml down
        ;;
    restart)
        docker compose -f docker/docker-compose.yml down
        docker compose -f docker/docker-compose.yml up -d --build
        ;;
    logs)
        docker compose -f docker/docker-compose.yml logs -f
        ;;
    shell)
        docker exec -it cs16-server bash
        ;;
    verify)
        ./deploy/verify.sh
        ;;
    *)
        cat <<EOF
Usage:
    ./scripts/dev.sh up
    ./scripts/dev.sh down
    ./scripts/dev.sh restart
    ./scripts/dev.sh logs
    ./scripts/dev.sh shell
    ./scripts/dev.sh verify
EOF
        ;;
esac