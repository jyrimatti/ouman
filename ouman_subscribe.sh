#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p websocat cacert curl jq nix
set -eu

object=$1

source ./ouman_env.sh

./ouman_login.sh

export DEVICEID=$(cat /tmp/ouman-headers-$USER | tail -n-1)
export TOKEN=$(cat /tmp/ouman-headers-$USER | head -n-1)

source ./ouman_objects.sh "$object"

WSTOKEN=$(curl -s "https://oulite.ouman.io/socket.io/1/?deviceid=$DEVICEID&token=$TOKEN" | sed 's/\([^:]*\):.*/\1/g')

(echo -n; sleep 1; echo '5:::{"name":"message","args":["{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"subscribe\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{}}}]}}"]}') |
  websocat -n "wss://oulite.ouman.io/socket.io/1/websocket/$WSTOKEN?deviceid=$DEVICEID&token=$TOKEN" |
  grep --line-buffered -v '3:::{"jsonrpc":"2.0","method":"device_connected"' |
  grep --line-buffered -v '3:::{"jsonrpc":"2.0","id":3,"result":"ok"}' |
  grep --line-buffered '3:::{"jsonrpc":"2.0","method":"value","params"' |
  sed --unbuffered 's/3::://' |
  jq '.params.objects | .[] | .properties."85".value'
