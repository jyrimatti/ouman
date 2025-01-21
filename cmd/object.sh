#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused
set -eu

object="$1"
getset="${2:-}"

. ./ouman_env.sh

if [ "$getset" = "Set" ]; then
  exit 1
else
  dash ./ouman_get.sh "$object" | sed 's/^\([0-9]*[.][0-9]\).*/\1/'
fi