#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-24.11-small -p sqlite nix dash websocat cacert curl jq gnugrep gnused coreutils
set -eu

date=$1

headers="$(dash ./ouman_login.sh)"

export DEVICEID="$(echo "$headers" | tail -n-1)"
export TOKEN="$(echo "$headers" | head -n-1)"

echo "Populating date $date"
for data in outsideTemp supplyTemperature indoorTemperature co2 ah supplyFan exhaustFan
do
    echo "Populating data $data"
    dash ./ouman_trend.sh $data "$date 00:00:00" "$date 23:59:59" | dash ./ouman_convert.sh $data | sqlite3 -cmd ".timeout 90000" ./ouman.db
done
