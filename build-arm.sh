#!/bin/bash
docker buildx use opencv-cuda-docker-builder

echo "Building OpenCV 3.4.14 with CUDA 11.3.1 on Ubuntu 18.04"
docker buildx bake -f docker-compose-arm.yml --load --progress=plain ubuntu18.04-cuda11.3.1
docker image push thecanadianroot/opencv-cuda:ubuntu18.04-cuda11.3.1-opencv3.4.14-arm64

echo "Building OpenCV 3.4.14 with CUDA 11.3.1 on Ubuntu 18.04 with ROS Melodic"
docker buildx bake -f docker-compose-arm-ros.yml --load --progress=plain ros-melodic-cuda11.3.1
docker image push thecanadianroot/opencv-cuda:ubuntu18.04-cuda11.3.1-opencv3.4.14-arm64-rosmelodic

echo "Building OpenCV 4.5.2 with CUDA 11.3.1 on Ubuntu 20.04"
docker buildx bake -f docker-compose-arm.yml --load --progress=plain ubuntu20.04-cuda11.3.1
docker image push thecanadianroot/opencv-cuda:ubuntu20.04-cuda11.3.1-opencv4.5.2-arm64

echo "Building OpenCV 4.5.2 with CUDA 11.3.1 on Ubuntu 20.04 with ROS Noetic"
docker buildx bake -f docker-compose-arm-ros.yml --load --progress=plain ros-noetic-cuda11.3.1
docker image push thecanadianroot/opencv-cuda:ubuntu20.04-cuda11.3.1-opencv4.5.2-arm64-rosnoetic