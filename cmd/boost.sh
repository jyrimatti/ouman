#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p bash nix
set -eu

getset=${1:-}
value=${4:-}
if [ "$value" == "true" ] || [ "$value" == "1" ]; then
  value="3";
else
  value="2";
fi

source ./ouman_env.sh

if [ "$getset" == "Set" ]; then
  ./ouman_post.sh fanSpeedMode_ $value
else
  echo $(($(./ouman_get.sh fanSpeedMode_) - 2))
fi
