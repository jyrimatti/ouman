#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused bkt
set -eu

object=$1

lock="${BKT_CACHE_DIR:-/tmp}/ouman.lock"

flock "$lock" \
    bkt --discard-failures --ttl 60s --stale 50s --modtime "$lock" -- \
        dash ./ouman_get_fetch.sh "$object"
