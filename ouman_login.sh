#! /usr/bin/env nix-shell
#! nix-shell --pure --keep OUMAN_USER --keep OUMAN_PASSWORD -i bash -I channel:nixos-23.05-small -p cacert curl jq
set -eu

if [ ! -f "/tmp/ouman-headers-$USER" ]; then
  curl --silent --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$OUMAN_USER"'","password":"'"$OUMAN_PASSWORD"'"}' https://api.ouman.io/login | jq '.token, (.devices | .[] .id)' | tr -d '"' > /tmp/ouman-headers-$USER
fi
for i in $(find /tmp/ouman-headers-$USER -mmin +60); do
  curl --silent --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$OUMAN_USER"'","password":"'"$OUMAN_PASSWORD"'"}' https://api.ouman.io/login | jq '.token, (.devices | .[] .id)' | tr -d '"' > /tmp/ouman-headers-$USER
done
