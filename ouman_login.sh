#! /usr/bin/env nix-shell
#! nix-shell --pure --keep OUMAN_USER --keep OUMAN_PASSWORD -i dash -I channel:nixos-23.05-small -p dash cacert curl jq flock findutils
set -eu

mkdir -p "/tmp/ouman-$USER"

login() {
  flock "/tmp/ouman-$USER/lock" curl --silent --show-error --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$OUMAN_USER"'","password":"'"$OUMAN_PASSWORD"'"}' https://api.ouman.io/login | jq '.token, (.devices | .[] .id)' | tr -d '"' > /tmp/ouman-$USER/headers
}

if [ ! -f "/tmp/ouman-$USER/headers" ]; then
  login
fi
for i in $(find /tmp/ouman-$USER/headers -mmin +60); do
  login
done
