#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused
set -eu

getset="$1"
object="$2"
characteristic="${3:-}"

. ./ouman_env.sh

if [ "$characteristic" = "On" ]; then
  echo 1
elif [ "$getset" = "Get" ]; then
  dash ./ouman_get.sh "$object"
else
  exit 1
fi
