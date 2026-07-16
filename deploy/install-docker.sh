#!/usr/bin/env bash
set -Eeuo pipefail

echo "[1/8] Remove Podman..."

sudo systemctl stop podman.socket 2>/dev/null || true
sudo apt remove -y podman podman-docker buildah 2>/dev/null || true

echo "[2/8] Update..."

sudo apt update

echo "[3/8] Install packages..."

sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "[4/8] Docker GPG..."

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "[5/8] Docker Repository..."

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

echo "[6/8] Install Docker..."

sudo apt update

sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "[7/8] Enable Docker..."

sudo systemctl enable docker
sudo systemctl restart docker

echo "[8/8] Version..."

docker version
docker compose version

echo
echo "Docker installed."