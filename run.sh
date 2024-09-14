#!/bin/bash
cd "$(dirname "$0")"

HOST_IP=$(hostname -I | awk '{print $1}')

./build.sh

docker run --shm-size=2gb \
    -p 25565:25565 \
    --mount type=bind,source="$(pwd)/mods",target="/usr/share/minecraft/mods" \
    minecraft-server:latest 