#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR --keep OUMAN_USER --keep OUMAN_PASSWORD -i dash -I channel:nixos-23.11-small -p dash cacert curl jq flock findutils
set -eu

minutes="60"

DIR="${XDG_RUNTIME_DIR:-/tmp}/ouman"

if [ -s "$DIR/headers" ]; then
  for i in $(find $DIR/headers -mmin -$minutes); do
    cat "$DIR/headers"
    exit 0
  done
fi

login() {
  flock "$DIR/lock" curl --no-progress-meter --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '{"type":"client","tag":"ouman/swegon","username":"'"$OUMAN_USER"'","password":"'"$OUMAN_PASSWORD"'"}' https://api.ouman.io/login\
    | jq '.token, (.devices | .[] .id)'\
    | tr -d '"'\
    > "$DIR/headers"
}

test -e "$DIR" || mkdir -p "$DIR"

if [ ! -f "$DIR/headers" ]; then
  login
fi
for i in $(find $DIR/headers -mmin +$minutes); do
  login
done

cat "$DIR/headers"