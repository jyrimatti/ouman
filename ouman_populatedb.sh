#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p sqlite nix dash
set -eu

date=$1

export DEVICEID=$(cat "/tmp/ouman-$USER/headers" | tail -n-1)
export TOKEN=$(cat "/tmp/ouman-$USER/headers" | head -n-1)

echo "Populating date $date"
for data in outsideTemp supplyTemperature indoorTemperature co2 ah supplyFan exhaustFan
do
    echo "Populating data $data"
    ./ouman_trend.sh $data "$date 00:00:00" "$date 23:59:59" | ./ouman_convert.sh $data | sqlite3 -cmd ".timeout 90000" ./ouman.db
done
