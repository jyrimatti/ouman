#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash sqlite nix cacert curl jq flock findutils websocat gnugrep gnused bkt
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

dash ./ouman_collect.sh | sqlite3 -cmd ".timeout 90000" ./ouman.db
