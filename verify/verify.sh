#!/bin/bash
set -e

############################################
#
# Følgende skjer i dette skriptet (krever bla. miljøvariabelen IMAGE):
# 1) henter manifest, samt  for miljøvariabelen IMAGE
# 2) teller antall ganger teksten "HTTP/1.1 404" kommer i head requesten etter manifestet
# 3) hvis antallet er 1, så er det et "is not existing" satt til true, hvis ikke false
#
############################################

REQUEST=$(curl --head --request GET "https://$IMAGE/manifests/$GITHUB_SHA -u $GITHUB_ACTOR:$GITHUB_TOKEN")
echo "
>---
Github head request:
$REQUEST>---
"
NOT_FOUND="HTTP/1.1\ 404"
NF_COUNT=$(echo "$REQUEST" | grep -c "$NOT_FOUND"  || true)
echo "
Found $NF_COUNT mentions of $NOT_FOUND"

if [ "$NF_COUNT" -eq 1 ]
  then
    echo ::set-output name=is_not_existing::true
    exit 0;
fi

echo ::set-output name=is_not_existing::false
