#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p nix
set -eu

getset=$1
object=$2
characteristic=${3:-}

. ./ouman_env.sh

if [ "$characteristic" = "On" ]; then
  echo 1
elif [ "$getset" = "Get" ]; then
  ./ouman_get.sh "$object"
else
  exit 1
fi
