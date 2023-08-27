#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p sqlite
set -eu

rm -f "./ouman.db.bak"
echo "VACUUM INTO './ouman.db.bak'" | sqlite3 -cmd ".timeout 90000" "./ouman.db"
