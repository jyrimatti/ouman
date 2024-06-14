#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused
set -eu

object="$1"
getset="${2:-}"
service="${3:-}"
characteristic="${4:-}"

. ./ouman_env.sh

if [ "$characteristic" = "On" ]; then
  echo 1
elif [ "$getset" = "Set" ]; then
  exit 1
else
  dash ./ouman_get.sh "$object" | sed 's/^\([0-9]*[.][0-9]\).*/\1/'
fi