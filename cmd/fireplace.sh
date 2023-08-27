#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p dash nix
set -eu

getset=${1:-}
value=${4:-}
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="1";
else
  value="0";
fi

. ./ouman_env.sh

if [ "$getset" = "Set" ]; then
  ./ouman_post.sh fireplaceFunctionOn $value
else
  ./ouman_get.sh fireplaceFunctionActive
fi
