#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet
# 1) henter headere til en GET request etter docker-manifest på github
# 2) teller antall ganger teksten "HTTP/* 404" kommer i head requesten etter manifestet
# 3) når antall av "HTTP/* 404" er 0, så blir "not found" satt lik:
#     - antall av "HTTP/* 401" er 1, så blir "not found" satt til false
#     - antall av "HTTP/*200" ikke er 0 ellers så feiler action
# 4) når forrige tester ikke slår til så er "is not found" true
#
############################################

URL="https://ghrc.io/v2/$GITHUB_REPOSITORY/manifests/$GITHUB_SHA"
REQUEST=$(curl --head --request GET "$URL" -u "$GITHUB_ACTOR:$GITHUB_TOKEN")
echo "
Headere i respons fra $URL:
----
$REQUEST"

HTTP="HTTP/2"
NO_OF_HTTP2=$(echo echo "$REQUEST" | grep -c "HTTP/2" || true)

if [ "$NO_OF_HTTP2" -eq 0 ]; then
  echo unable to find protocol HTTP/2, using HTTP/1.1...
  HTTP="HTTP/1.1"
fi

NOT_FOUND="$HTTP\ 404"
NF_COUNT=$(echo "$REQUEST" | grep -c "$NOT_FOUND" || true)

echo "
Found $NF_COUNT mentions of $NOT_FOUND"

if [ "$NF_COUNT" -eq 0 ]; then
  UNAUTHORIZED="$HTTP\ 401"
  UNAUTHORIZED_COUNT=$(echo "$REQUEST" | grep -c "$UNAUTHORIZED" || true)

  if [ "$UNAUTHORIZED_COUNT" -eq 1 ]; then
    echo unauthorized, assuming not found
    echo ::set-output name=not_found::false
    exit 0;
  fi

  SUCCESS="$HTTP\ 200"
  SUCCESS_COUNT=$(echo "$REQUEST" | grep -c "$SUCCESS" || true)

  if [ "$SUCCESS_COUNT" -eq 0 ]; then
    echo ::error "not a successful http request ($HTTP) according to headers"
    exit 1;
  fi

  echo a successful http request for headers
  echo ::set-output name=not_found::false
  exit 0;
fi

echo ::set-output name=not_found::true
