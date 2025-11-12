#!/bin/bash
# Pterodactyl Dependency Installation Script for Parrot OS (Debian-based)

set -e

echo "[1/5] Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "[2/5] Installing base dependencies..."
sudo apt install -y curl unzip git redis-server mariadb-server nginx certbot python3-certbot-nginx php php-cli php-fpm php-mysql php-redis php-gd php-mbstring php-xml php-curl php-zip php-bcmath php-intl composer ufw

echo "[3/5] Installing Docker..."
sudo apt remove -y podman docker docker-engine docker.io containerd runc || true
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "[4/5] Enabling services..."
sudo systemctl enable --now mariadb redis-server nginx docker

echo "[5/5] Firewall configuration..."
sudo ufw allow 22,80,443,8080,2022,25565/tcp
sudo ufw reload

echo "Dependencies installed successfully!"

