#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix dash
set -eu

. ./ouman_env.sh

test "$(./cmd/object.sh co2 $*)" -gt 650 && echo 1 || echo 0
