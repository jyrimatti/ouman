#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix dash
set -eu

getset=${1:-}
value=${4:-}
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="5";
else
  value="0";
fi

. ./ouman_env.sh

if [ "$getset" = "Set" ]; then
  ./ouman_post.sh summerCoolingFunctionMode $value
else
  echo $(($(./ouman_get.sh summerCoolingFunctionMode) / 5))
fi
