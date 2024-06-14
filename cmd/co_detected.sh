#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused
set -eu

. ./ouman_env.sh

test "$(dash ./cmd/object.sh co2 $*)" -gt 900 && echo 1 || echo 0
