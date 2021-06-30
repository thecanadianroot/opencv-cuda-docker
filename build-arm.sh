#!/bin/bash
docker buildx use arm64-builder
docker buildx bake -f docker-compose-arm.yml --load --progress=plain
docker buildx bake -f docker-compose-arm-ros.yml --load --progress=plain
