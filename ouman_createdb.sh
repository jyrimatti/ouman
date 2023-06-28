#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p sqlite
set -eu

sqlite3 ouman.db < ouman_create.sql