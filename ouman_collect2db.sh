#!/bin/bash
set -eu

user=$1
pass=$2
dir=$3

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$scripts/ouman_login.sh "$user" "$pass"

export DEVICEID=$(cat /tmp/ouman-headers | tail -n-1)
export TOKEN=$(cat /tmp/ouman-headers | head -n-1)

start=$(date '+%C%y-%m-%d %H:%M:%S' -d '-30minutes')
end=$(date '+%C%y-%m-%d %H:%M:%S')

$scripts/ouman_trend.sh outsideTemp       "$start" "$end" | $scripts/ouman_convert.sh outsideTemp       | sqlite3 -cmd ".timeout 90000" $dir/ouman.db
$scripts/ouman_trend.sh supplyTemperature "$start" "$end" | $scripts/ouman_convert.sh supplyTemperature | sqlite3 -cmd ".timeout 90000" $dir/ouman.db
$scripts/ouman_trend.sh indoorTemperature "$start" "$end" | $scripts/ouman_convert.sh indoorTemperature | sqlite3 -cmd ".timeout 90000" $dir/ouman.db
$scripts/ouman_trend.sh co2               "$start" "$end" | $scripts/ouman_convert.sh co2               | sqlite3 -cmd ".timeout 90000" $dir/ouman.db
$scripts/ouman_trend.sh ah                "$start" "$end" | $scripts/ouman_convert.sh ah                | sqlite3 -cmd ".timeout 90000" $dir/ouman.db
$scripts/ouman_trend.sh supplyFan         "$start" "$end" | $scripts/ouman_convert.sh supplyFan         | sqlite3 -cmd ".timeout 90000" $dir/ouman.db
$scripts/ouman_trend.sh exhaustFan        "$start" "$end" | $scripts/ouman_convert.sh exhaustFan        | sqlite3 -cmd ".timeout 90000" $dir/ouman.db
