#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p sqlite
set -eu

sqlite3 ouman.db < ouman_create.sql