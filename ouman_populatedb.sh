#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p sqlite nix dash websocat cacert curl jq gnugrep gnused coreutils bkt
set -eu

date=$1

echo "Populating date $date"
for data in outsideTemp supplyTemperature indoorTemperature co2 ah supplyFan exhaustFan
do
    echo "Populating data $data"
    dash ./ouman_trend.sh $data "$date 00:00:00" "$date 23:59:59" | dash ./ouman_convert.sh $data | sqlite3 -cmd ".timeout 90000" ./ouman.db
done
