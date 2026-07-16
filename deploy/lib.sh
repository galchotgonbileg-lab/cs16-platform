#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

log() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

error() {
    echo -e "${RED}[ERROR]${NC} $*"
    exit 1
}

step() {
    echo -e "${BLUE}==>${NC} $*"
}

exists() {
    command -v "$1" >/dev/null 2>&1
}

require_root() {
    if [ "$(id -u)" -ne 0 ]; then
        error "Run as root."
    fi
}

require_command() {
    exists "$1" || error "$1 not installed."
}

require_file() {
    [ -f "$1" ] || error "Missing file: $1"
}

require_directory() {
    [ -d "$1" ] || error "Missing directory: $1"
}

run() {
    log "$*"
    "$@"
}

docker_compose() {
    docker compose -f "${ROOT}/docker/docker-compose.yml" "$@"
}