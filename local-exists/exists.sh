#!/bin/bash
set -x

############################################
#
# Følgende skjer i dette skriptet
# 1) setter image id som input
# 2) sjekker om docker image finnes i lokalt docker image
#
############################################

IMAGE_ID=$1
IS_NOT_FOUND="false"

docker inspect $IMAGE_ID || IS_NOT_FOUND="true"

echo ::set-output name=not_found::"$IS_NOT_FOUND"
