#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet (krever bla. miljøvariabelen IMAGE):
# 1) bygger et docker image fra miljøvariabelen IMAGE (bruker podman)
# 2) bruker GITHUB_TOKEN til docker login til repoet som bygges
# 3) pusher image til github registry
#
############################################

sudo podman build --tag ${IMAGE} .
sudo podman login docker.pkg.github.com -u ${GITHUB_REPOSITORY} -p ${GITHUB_TOKEN}
sudo podman push ${IMAGE}
