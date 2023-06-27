#!/bin/bash
#! /usr/bin/env nix-shell
#! nix-shell -I channel:nixos-21.11-small -i bash -p websocat jq
set -eu

object=$1
value=$2
user=$3
pass=$4

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$scripts/ouman_login.sh "$user" "$pass"

export DEVICEID=$(cat /tmp/ouman-headers | tail -n-1)
export TOKEN=$(cat /tmp/ouman-headers | head -n-1)

source $scripts/ouman_objects.sh "$object"

WSTOKEN=$(curl -s "https://oulite.ouman.io/socket.io/1/?deviceid=$DEVICEID&token=$TOKEN" | sed 's/\([^:]*\):.*/\1/g')

# TODO:
(sleep 1; echo '5:::{"name":"message","args":["{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"write\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{\"value\":'"$value"'}}}]}}"]}'; sleep 3; echo '5:::{"name":"message", "args":[]}') |
  websocat --max-messages=2 "wss://oulite.ouman.io/socket.io/1/websocket/$WSTOKEN?deviceid=$DEVICEID&token=$TOKEN" |
  grep -v '3:::{"jsonrpc":"2.0","method":"device_connected"' |
  grep '3:::{"jsonrpc":"2.0","id":3,"result"' |
  sed 's/3::://' |
  jq '.result'
