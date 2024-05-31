#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash sqlite nix cacert curl jq flock findutils websocat gnugrep gnused
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

. ./ouman_env.sh

headers="$(dash ./ouman_login.sh)"

export DEVICEID="$(echo "$headers" | tail -n-1)"
export TOKEN="$(echo "$headers" | head -n-1)"

start="$(date '+%C%y-%m-%d %H:%M:%S' -d '-30minutes')"
end="$(date '+%C%y-%m-%d %H:%M:%S')"

dash ./ouman_trend.sh outsideTemp       "$start" "$end" | dash ./ouman_convert.sh outsideTemp       | sqlite3 -cmd ".timeout 90000" ./ouman.db
dash ./ouman_trend.sh indoorTemperature "$start" "$end" | dash ./ouman_convert.sh indoorTemperature | sqlite3 -cmd ".timeout 90000" ./ouman.db
dash ./ouman_trend.sh supplyTemperature "$start" "$end" | dash ./ouman_convert.sh supplyTemperature | sqlite3 -cmd ".timeout 90000" ./ouman.db
dash ./ouman_trend.sh co2               "$start" "$end" | dash ./ouman_convert.sh co2               | sqlite3 -cmd ".timeout 90000" ./ouman.db
dash ./ouman_trend.sh ah                "$start" "$end" | dash ./ouman_convert.sh ah                | sqlite3 -cmd ".timeout 90000" ./ouman.db
dash ./ouman_trend.sh supplyFan         "$start" "$end" | dash ./ouman_convert.sh supplyFan         | sqlite3 -cmd ".timeout 90000" ./ouman.db
dash ./ouman_trend.sh exhaustFan        "$start" "$end" | dash ./ouman_convert.sh exhaustFan        | sqlite3 -cmd ".timeout 90000" ./ouman.db
