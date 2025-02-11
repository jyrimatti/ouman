#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash nix cacert curl jq flock findutils websocat gnugrep gnused bkt
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

start="$(date '+%C%y-%m-%d %H:%M:%S' -d '-30minutes')"
end="$(date '+%C%y-%m-%d %H:%M:%S')"

dash ./ouman_trend.sh outsideTemp       "$start" "$end" | dash ./ouman_convert.sh outsideTemp
dash ./ouman_trend.sh indoorTemperature "$start" "$end" | dash ./ouman_convert.sh indoorTemperature
dash ./ouman_trend.sh supplyTemperature "$start" "$end" | dash ./ouman_convert.sh supplyTemperature
dash ./ouman_trend.sh co2               "$start" "$end" | dash ./ouman_convert.sh co2
dash ./ouman_trend.sh ah                "$start" "$end" | dash ./ouman_convert.sh ah
dash ./ouman_trend.sh supplyFan         "$start" "$end" | dash ./ouman_convert.sh supplyFan
dash ./ouman_trend.sh exhaustFan        "$start" "$end" | dash ./ouman_convert.sh exhaustFan
