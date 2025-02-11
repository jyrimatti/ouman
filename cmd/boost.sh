#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused bkt
set -eu

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="3";
else
  value="2";
fi

if [ "$getset" = "Set" ]; then
  response="$(dash ./ouman_post.sh fanSpeedMode_ $value)"
  echo "$((value - 2))"
else
  ret="$(dash ./ouman_get.sh fanSpeedMode_)"
  if [ "$ret" -lt "3" ]; then
    echo 0
  else
    echo 1
  fi
fi
