#!/bin/bash

set -o nounset
set -o errexit

wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 || { echo "Failed to download jq" >&2 ; exit 1; }
chmod +x jq || { echo "Failed to make jq executable" >&2 ; exit 1; }

curl -X GET -H 'Content-Length: 0' -u $ARTIFACTORY_AUTH "https://repo.jenkins-ci.org/api/security/users" > artifactory-users-raw.json
./jq 'map(select(.realm | test("ldap"))) | [ .[].name ] | sort' artifactory-users-raw.json
