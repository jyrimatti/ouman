#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused bkt
set -eu

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="4"; # full
else
  value="0"; # off
fi

if [ "$getset" = "Set" ]; then
  response="$(dash ./ouman_post.sh summerCoolingFunctionMode $value)"
  if [ "$value" -gt 0 ]; then
    echo 1
  else
    echo 0
  fi
else
  if [ "$(dash ./ouman_get.sh summerCoolingFunctionMode)" -gt 0 ]; then
    echo 1
  else
    echo 0
  fi
fi
