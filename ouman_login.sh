#! /usr/bin/env nix-shell
#! nix-shell --pure --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash cacert curl jq flock findutils bkt
set -eu

. ./ouman_env.sh

postdata='{"type":"client","tag":"ouman/swegon","username":"'"$OUMAN_USER"'","password":"'"$OUMAN_PASSWORD"'"}'

bkt --discard-failures --ttl 60m --stale 30m -- \
    flock "${BKT_CACHE_DIR:-/tmp}/ouman-login.lock" -c \
    "curl --no-progress-meter --connect-timeout 30 -X POST -H 'Content-Type: application/json' -d '$postdata' https://api.ouman.io/login \
      | jq -r '(.devices | .[] .id) + \" \" + .token'"
