#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet
# 1) henter headere til en GET request etter docker-manifest på github
# 2) teller antall ganger teksten "HTTP/1.1 404" kommer i head requesten etter manifestet
# 3a) når antall av "HTTP/1.1 404" er 0, så blir "not found" satt false
#     - hvis antall av "HTTP/1.1 301" er 1, så blir "not found" satt til false
#     - hvis antall av "HTTP/1.0 200" ikke er 0 ellers så feiler action
# 4) når forrige tester ikke slår til så er "is not found" true
#
############################################

IMAGE_NAME=$1

REQUEST=$(curl --head --request GET "https://docker.pkg.github.com/v2/$GITHUB_REPOSITORY/$IMAGE_NAME/manifests/$GITHUB_SHA" -u "$GITHUB_ACTOR:$GITHUB_TOKEN")
echo "
Github head request:
----
$REQUEST"

NOT_FOUND="HTTP/1.1\ 404"
NF_COUNT=$(echo "$REQUEST" | grep -c "$NOT_FOUND" || true)

echo "
Found $NF_COUNT mentions of $NOT_FOUND"

if [ "$NF_COUNT" -eq 0 ]; then
  MOVED="HTTP/1.1\ 301"
  MOVED_COUNT=$(echo "$REQUEST" | grep -c "$MOVED" || true)

  if [ "$MOVED_COUNT" -eq 1 ]; then
    echo perminantly moved, assuming not found
    echo ::set-output name=not_found::false
    exit 0;
  fi

  SUCCESS="HTTP/1.1\ 200"
  SUCCESS_COUNT=$(echo "$REQUEST" | grep -c "$SUCCESS" || true)

  if [ "$SUCCESS_COUNT" -eq 0 ]; then
    echo ::error not a successful http request for headers
    exit 1;
  fi

  echo a successful http request for headers
  echo ::set-output name=not_found::false
  exit 0;
fi

echo ::set-output name=not_found::true
