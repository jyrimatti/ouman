#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep OUMAN_USER --keep OUMAN_PASSWORD -i dash -I channel:nixos-23.11-small -p dash cacert curl jq flock findutils
set -eu

minutes="60"

if [ -s "/tmp/ouman-$USER/headers" ]; then
  for i in $(find /tmp/ouman-$USER/headers -mmin -$minutes); do
    exit 0
  done
fi

login() {
  flock "/tmp/ouman-$USER/lock" curl --no-progress-meter --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$OUMAN_USER"'","password":"'"$OUMAN_PASSWORD"'"}' https://api.ouman.io/login\
    | jq '.token, (.devices | .[] .id)'\
    | tr -d '"'\
    > /tmp/ouman-$USER/headers
}

test -e "/tmp/ouman-$USER" || mkdir -p "/tmp/ouman-$USER"

if [ ! -f "/tmp/ouman-$USER/headers" ]; then
  login
fi
for i in $(find /tmp/ouman-$USER/headers -mmin +$minutes); do
  login
done
