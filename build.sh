#!/bin/bash
cd "$(dirname "$0")"

DOCKER_BUILDKIT=1 docker buildx build -f Dockerfile      . -t minecraft-server:latest
