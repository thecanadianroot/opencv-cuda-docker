#!/bin/bash
docker buildx use builder
docker buildx bake -f docker-compose-arm.yml --load