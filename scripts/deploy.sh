#!/usr/bin/env bash
set -euo pipefail

cd /opt/keycloak

echo "==> Sync repo"
git fetch --all
git reset --hard origin/main

if [ ! -f .env ]; then
  echo "ERROR: /opt/keycloak/.env no existe"
  exit 1
fi

echo "==> Pull images"
docker compose pull

echo "==> Recreate nginx"
docker compose up -d --force-recreate nginx

echo "==> Start services"
docker compose up -d

echo "==> Status"
docker compose ps