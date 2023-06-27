#!/bin/bash
set -eu

dir=$1
scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f "$dir/ouman.db.bak"
echo "VACUUM INTO '$dir/ouman.db.bak'" | sqlite3 -cmd ".timeout 90000" "$dir/ouman.db"
