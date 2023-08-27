#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p sqlite
set -eu

sqlite3 ouman.db < ouman_create.sql