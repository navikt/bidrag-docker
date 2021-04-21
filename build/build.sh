#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet (krever bla. miljøvariabelen IMAGE, GITHUB_REPOSITORY og GITHUB_TOKEN):
# 1) sjekker om vi skal bruke podman eller docker
# 2) bygger et docker image fra miljøvariabelen IMAGE
# 3) bruker GITHUB_TOKEN til docker login til repoet som bygges
# 4) pusher image til github registry
#
############################################

if type podman  > /dev/null; then
  sudo podman build --tag ${IMAGE} .
  sudo podman login docker.pkg.github.com -u ${GITHUB_REPOSITORY} -p ${GITHUB_TOKEN}
  sudo podman push ${IMAGE}
else
  docker build --tag ${IMAGE} .
  docker login docker.pkg.github.com -u ${GITHUB_REPOSITORY} -p ${GITHUB_TOKEN}
  docker push ${IMAGE}
fi
