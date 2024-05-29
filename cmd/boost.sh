#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH -i dash -I channel:nixos-23.11-small -p nix dash
set -eu

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="3";
else
  value="2";
fi

. ./ouman_env.sh

if [ "$getset" = "Set" ]; then
  response="$(./ouman_post.sh fanSpeedMode_ $value)"
  echo 1
else
  ret="$(./ouman_get.sh fanSpeedMode_)"
  if [ "$ret" -lt "3" ]; then
    echo 0
  else
    echo 1
  fi
fi
