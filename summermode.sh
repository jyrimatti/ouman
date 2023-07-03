#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p bash nix
set -eu

getset=${1:-}
value=${4:-}
if [ "$value" == "true" ] || [ "$value" == "1" ]; then
  value="2"; # COMFORT (summer)
else
  value="1"; # ECO (winter)
fi

source ./ouman_env.sh

if [ "$getset" == "Set" ]; then
  ./ouman_post.sh heatingMode $value
else
  echo "$(($(./ouman_get.sh heatingMode) - 1))"
fi
