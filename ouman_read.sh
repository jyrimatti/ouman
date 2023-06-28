#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p bash nix
set -eu

getset=$1
object=$2
characteristic=${3:-}

source ./ouman_env.sh

if [ "$characteristic" == "On" ]; then
  echo 1
elif [ "$getset" == "Get" ]; then
  ./ouman_get.sh "$object"
else
  exit 1
fi