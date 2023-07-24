#! /usr/bin/env nix-shell
#! nix-shell --pure --keep OUMAN_USER --keep OUMAN_PASSWORD -i bash -I channel:nixos-23.05-small -p cacert curl jq flock
set -eu

login() {
  flock "/tmp/ouman-lock-$USER" curl --silent --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$OUMAN_USER"'","password":"'"$OUMAN_PASSWORD"'"}' https://api.ouman.io/login | jq '.token, (.devices | .[] .id)' | tr -d '"' > /tmp/ouman-headers-$USER
}

if [ ! -f "/tmp/ouman-headers-$USER" ]; then
  login
fi
for i in $(find /tmp/ouman-headers-$USER -mmin +60); do
  login
done
