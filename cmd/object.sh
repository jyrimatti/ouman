#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p bash nix
set -eu

object=$1
getset=$2
service=$3
characteristic=${4:-}

source ./ouman_env.sh

if [ "$characteristic" == "On" ]; then
  echo 1
elif [ "$getset" == "Get" ]; then
  ./ouman_get.sh "$object"
else
  exit 1
fi