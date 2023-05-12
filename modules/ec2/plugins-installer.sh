#!/bin/bash

set -eo pipefail

JENKINS_URL='http://localhost:8080'

JENKINS_CRUMB=$(curl -s --cookie-jar /tmp/cookies -u admin:admin "${JENKINS_URL}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,%22:%22,//crumb)")

JENKINS_TOKEN=$(curl -u admin:admin -H "${JENKINS_CRUMB}" -s \
                                    --cookie /tmp/cookies $JENKINS_URL'/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken' \
                                    --data 'newTokenName=GlobalToken' | jq -r '.data.tokenValue')

echo "$JENKINS_URL"
echo "$JENKINS_CRUMB"
echo "$JENKINS_TOKEN"

while read -r plugin; do
   echo "........Installing ${plugin} .."
   curl -X POST --data "<jenkins><install plugin='${plugin}' /></jenkins>" -H 'Content-Type: text/xml' "$JENKINS_URL/pluginManager/installNecessaryPlugins" --user "admin:$JENKINS_TOKEN"
done < plugins.txt



