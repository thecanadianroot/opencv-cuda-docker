#!/bin/bash
docker buildx use opencv-cuda-docker-builder
docker buildx bake -f docker-compose-arm.yml --load --progress=plain
docker buildx bake -f docker-compose-arm-ros.yml --load --progress=plain
echo "Pushing docker images..."
docker image push thecanadianroot/opencv-cuda:ubuntu18.04-cuda11.0.3-opencv3.4.14-arm64
docker image push thecanadianroot/opencv-cuda:ubuntu18.04-cuda11.3.1-opencv3.4.14-arm64
docker image push thecanadianroot/opencv-cuda:ubuntu20.04-cuda11.3.1-opencv4.5.2-arm64
docker image push thecanadianroot/opencv-cuda:ubuntu18.04-cuda11.0.3-opencv3.4.14-arm64-rosmelodic
docker image push thecanadianroot/opencv-cuda:ubuntu18.04-cuda11.3.1-opencv3.4.14-arm64-rosmelodic
docker image push thecanadianroot/opencv-cuda:ubuntu20.04-cuda11.3.1-opencv4.5.2-arm64-rosnoetic