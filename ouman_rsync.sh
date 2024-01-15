#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p rsync sqlite
set -eu

remoteuser=$1
remotehost=$2
remotefile=$3

foo() {
    echo 'PRAGMA locking_mode = EXCLUSIVE;'
    echo 'BEGIN EXCLUSIVE;'
    rsync -avzq --bwlimit=1000 -e "ssh -qo StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" ./ouman.db "$remoteuser@$remotehost:$remotefile" 1>&2
    echo 'COMMIT;'
    echo '.quit'
}

foo | sqlite3 ./ouman.db
