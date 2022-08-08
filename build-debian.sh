#!/bin/bash -xe

# Build deploy docker image
GIT_COMMIT_ID=$(git rev-parse HEAD | cut -c1-7)
IMAGE="774915305292.dkr.ecr.us-west-2.amazonaws.com/debian-with-opencv:latest-x86"
AWS_CLI_VERSION=$(aws --version 2>&1 | cut -d " " -f1 | cut -d "/" -f2 | cut -c 1)

docker build --no-cache --pull \
  -t "${IMAGE}" \
  -f DebianDockerfile .
aws ecr get-login --no-include-email --region us-west-2 | bash
# Push docker images
docker push "${IMAGE}"