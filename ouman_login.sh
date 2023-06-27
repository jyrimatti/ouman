#!/bin/bash
#! /usr/bin/env nix-shell
#! nix-shell -I channel:nixos-21.11-small -i bash -p jq
set -eu

user=$1
pass=$2

if [ ! -f "/tmp/ouman-headers" ]; then
  curl --silent --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$user"'","password":"'"$pass"'"}' https://api.ouman.io/login | jq '.token, (.devices | .[] .id)' | tr -d '"' > /tmp/ouman-headers
fi
for i in $(find /tmp/ouman-headers -mmin +60); do
  curl --silent --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$user"'","password":"'"$pass"'"}' https://api.ouman.io/login | jq '.token, (.devices | .[] .id)' | tr -d '"' > /tmp/ouman-headers
done
