#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH -i dash -I channel:nixos-23.11-small -p nix dash
set -eu

. ./ouman_env.sh

test "$(./cmd/object.sh co2 $*)" -gt 900 && echo 1 || echo 0
