#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p sqlite nix
set -eu

. ./ouman_env.sh

./ouman_login.sh

export DEVICEID=$(cat "/tmp/ouman-$USER/headers" | tail -n-1)
export TOKEN=$(cat "/tmp/ouman-$USER/headers" | head -n-1)

start=$(date '+%C%y-%m-%d %H:%M:%S' -d '-30minutes')
end=$(date '+%C%y-%m-%d %H:%M:%S')

./ouman_trend.sh outsideTemp       "$start" "$end" | ./ouman_convert.sh outsideTemp       | sqlite3 -cmd ".timeout 90000" ./ouman.db
./ouman_trend.sh supplyTemperature "$start" "$end" | ./ouman_convert.sh supplyTemperature | sqlite3 -cmd ".timeout 90000" ./ouman.db
./ouman_trend.sh indoorTemperature "$start" "$end" | ./ouman_convert.sh indoorTemperature | sqlite3 -cmd ".timeout 90000" ./ouman.db
./ouman_trend.sh co2               "$start" "$end" | ./ouman_convert.sh co2               | sqlite3 -cmd ".timeout 90000" ./ouman.db
./ouman_trend.sh ah                "$start" "$end" | ./ouman_convert.sh ah                | sqlite3 -cmd ".timeout 90000" ./ouman.db
./ouman_trend.sh supplyFan         "$start" "$end" | ./ouman_convert.sh supplyFan         | sqlite3 -cmd ".timeout 90000" ./ouman.db
./ouman_trend.sh exhaustFan        "$start" "$end" | ./ouman_convert.sh exhaustFan        | sqlite3 -cmd ".timeout 90000" ./ouman.db
