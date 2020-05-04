#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet:
# 1) bygger et docker image fra miljøvariabelen IMAGE
# 2) bruker GITHUB_TOKEN til docker login til repoet som bygges
# 3) pusher image til github registry
#
############################################

docker build --tag ${IMAGE} .
docker login docker.pkg.github.com -u ${GITHUB_REPOSITORY} -p ${GITHUB_TOKEN}
docker push ${IMAGE}
