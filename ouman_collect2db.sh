#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash sqlite nix cacert curl jq flock findutils websocat gnugrep gnused
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

dash ./ouman_collect.sh | sqlite3 -cmd ".timeout 90000" ./ouman.db
