#! /usr/bin/env nix-shell
#! nix-shell --pure --keep OUMAN_USER --keep OUMAN_PASSWORD -i bash -I channel:nixos-23.05-small -p websocat cacert curl jq nix
set -eu

object=$1
value=$2

./ouman_login.sh

export DEVICEID=$(cat /tmp/ouman-headers | tail -n-1)
export TOKEN=$(cat /tmp/ouman-headers | head -n-1)

source ./ouman_objects.sh "$object"

WSTOKEN=$(curl -s "https://oulite.ouman.io/socket.io/1/?deviceid=$DEVICEID&token=$TOKEN" | sed 's/\([^:]*\):.*/\1/g')

# TODO:
(sleep 1; echo '5:::{"name":"message","args":["{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"write\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{\"value\":'"$value"'}}}]}}"]}'; sleep 3; echo '5:::{"name":"message", "args":[]}') |
  websocat --max-messages=2 "wss://oulite.ouman.io/socket.io/1/websocket/$WSTOKEN?deviceid=$DEVICEID&token=$TOKEN" |
  grep -v '3:::{"jsonrpc":"2.0","method":"device_connected"' |
  grep '3:::{"jsonrpc":"2.0","id":3,"result"' |
  sed 's/3::://' |
  jq '.result'
