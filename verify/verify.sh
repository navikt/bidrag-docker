#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet (krever bla. miljøvariabelen IMAGE):
# 1) henter manifest, samt  for miljøvariabelen IMAGE
# 2) teller antall ganger teksten "HTTP/1.1 404" kommer i head requesten etter manifestet
# 3) hvis antall av HTTP/1.1 404 er 0, så blir "is not existing" satt false, hvis ikke true
#
############################################

REQUEST=$(curl --head --request GET "https://$IMAGE/manifests/$GITHUB_SHA" -u "$GITHUB_ACTOR:$GITHUB_TOKEN")
echo "
Github head request:
----
$REQUEST"

NOT_FOUND="HTTP/1.1\ 404"
NF_COUNT=$(echo "$REQUEST" | grep -c "$NOT_FOUND"  || true)

echo "
Found $NF_COUNT mentions of $NOT_FOUND"

if [ "$NF_COUNT" -eq 0 ]
  then
    echo ::set-output name=is_not_existing::false
    exit 0;
fi

echo ::set-output name=is_not_existing::true
