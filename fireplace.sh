#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p bash nix
set -eu

getset=$1
value=${2:-}
if [ "$value" == "true" ]; then
  value="1";
else
  value="0";
fi

source ./ouman_env.sh

if [ "$getset" == "Set" ]; then
  ./ouman_post.sh fireplaceFunctionOn $value
else
  ./ouman_get.sh fireplaceFunctionActive
fi
