#!/bin/bash
docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64
cat /proc/sys/fs/binfmt_misc/qemu-aarch64
docker buildx create --use --name arm64-builder --platform=linux/arm64
docker buildx inspect --bootstrap