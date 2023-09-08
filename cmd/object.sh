#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p dash nix
set -eu

object=$1
getset=$2
service=${3:-}
characteristic=${4:-}

. ./ouman_env.sh

if [ "$characteristic" = "On" ]; then
  echo 1
elif [ "$getset" = "Get" ]; then
  ./ouman_get.sh "$object" | sed 's/^\([0-9]*[.][0-9]\).*/\1/'
else
  exit 1
fi