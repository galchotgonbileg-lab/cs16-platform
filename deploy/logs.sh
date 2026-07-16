#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE="${ROOT}/docker/docker-compose.yml"

SERVICE="${1:-}"

if [ -z "${SERVICE}" ]; then
    docker compose -f "${COMPOSE}" logs -f --tail=100
else
    docker compose -f "${COMPOSE}" logs -f --tail=100 "${SERVICE}"
fi