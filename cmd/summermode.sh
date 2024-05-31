#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused
set -eu

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="2"; # COMFORT (summer)
else
  value="1"; # ECO (winter)
fi

. ./ouman_env.sh

if [ "$getset" = "Set" ]; then
  response="$(dash ./ouman_post.sh heatingMode $value)"
  echo 1
else
  echo "$(($(dash ./ouman_get.sh heatingMode) - 1))"
fi
