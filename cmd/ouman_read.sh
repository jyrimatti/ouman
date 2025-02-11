#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused bkt
set -eu

getset="$1"
object="$2"
characteristic="${3:-}"

if [ "$characteristic" = "On" ]; then
  echo 1
elif [ "$getset" = "Get" ]; then
  dash ./ouman_get.sh "$object"
else
  exit 1
fi
