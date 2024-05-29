#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH -i dash -I channel:nixos-23.11-small -p dash gnused coreutils
set -eu

sed -E "s/^(.*);(.*)/INSERT INTO $1 SELECT strftime('%s', '\1')$(date +'%z' | sed 's/+0/-/' | sed 's/00//')*60*60, \2 WHERE strftime('%s', '\1')$(date +'%z' | sed 's/+0/-/' | sed 's/00//')*60*60 NOT IN (SELECT instant FROM $1) AND \2 NOT IN (SELECT measurement FROM $1 WHERE instant < strftime('%s', '\1')$(date +'%z' | sed 's/+0/-/' | sed 's/00//')*60*60 ORDER BY instant DESC limit 1);/"