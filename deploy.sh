#!/bin/bash

if [[ $GIT_BRANCH == 'origin/dev' ]]; then
  # Build and push to the development repository
  build.sh
  docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
  docker push $DOCKER_BFLASK_IMAGE
  docker tag my-img $DOCKER_BFLASK_IMAGE
  docker push dev/docker repo
elif [[ $GIT_BRANCH == 'origin/main' ]]; then
  # Build and push to the production repository
  build.sh
  docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
  docker push $DOCKER_BFLASK_IMAGE
  docker tag my-img $DOCKER_BFLASK_IMAGE
  docker push prod/docker
else
  echo "Deployment error"
fi
