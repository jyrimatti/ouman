#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused bkt
set -eu

object="$1"
getset="${2:-}"

if [ "$getset" = "Set" ]; then
  exit 1
else
  dash ./ouman_get.sh "$object" | sed 's/^\([0-9]*[.][0-9]\).*/\1/'
fi