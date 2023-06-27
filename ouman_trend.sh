#!/bin/bash
#! /usr/bin/env nix-shell
#! nix-shell -I channel:nixos-21.11-small -i bash -p websocat jq
set -eu

export DEVICEID=$(cat /tmp/ouman-headers | tail -n-1)
export TOKEN=$(cat /tmp/ouman-headers | head -n-1)

DATE1=$(date '+%C%y-%m-%d %H:%M:%S' -d "$2")
DATE2=${3:-$(date '+%C%y-%m-%d %H:%M:%S' -d "$DATE1 +1 day")}

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $scripts/ouman_objects.sh "$1"

WSTOKEN=$(curl -s "https://oulite.ouman.io/socket.io/1/?deviceid=$DEVICEID&token=$TOKEN" | sed 's/\([^:]*\):.*/\1/g')

(echo -n; sleep 1; echo '5:::{"name":"message","args":["{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"readtrend2\",\"params\":{\"objects\":[{\"starttime\":\"'"$DATE1"'\",\"endtime\":\"'"$DATE2"'\",\"id\":\"'"$OBJECTID"'\",\"device\":255}]}}"]}') |
  websocat -n --max-messages-rev=3 -B512000 "wss://oulite.ouman.io/socket.io/1/websocket/$WSTOKEN?deviceid=$DEVICEID&token=$TOKEN" |
  grep -v '3:::{"jsonrpc":"2.0","method":"device_connected"' |
  grep '3:::{"jsonrpc":"2.0","id":3,"result"' |
  sed 's/3::://' |
  jq '.result.objects | .[] | .trenddata' |
  tr -d '"' |
  tr '@' '\n' |
  grep '[^ ]' |
  uniq