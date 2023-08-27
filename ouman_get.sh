#! /usr/bin/env nix-shell
#! nix-shell --pure --keep OUMAN_USER --keep OUMAN_PASSWORD -i dash -I channel:nixos-23.05-small -p cacert websocat curl jq nix gnugrep gnused
set -eu

object=$1

./ouman_login.sh

export DEVICEID=$(cat "/tmp/ouman-$USER/headers" | tail -n-1)
export TOKEN=$(cat "/tmp/ouman-$USER/headers" | head -n-1)

. ./ouman_objects.sh "$object"

# 22 == ? (0.05)
# 28 == decription
# 34 == ? (5)
# 75 == id
# 77 == ? (_ADDR1_SwegonCasa_ExternalFreshairtemperature)
# 79 == ? (150)
# 85 == value
# 111 == ? (0)
# 117 == ? (1)
# 187 == ? (10)

WSTOKEN=$(curl -s "https://oulite.ouman.io/socket.io/1/?deviceid=$DEVICEID&token=$TOKEN" | sed 's/\([^:]*\):.*/\1/g')

(sleep 1; echo '5:::{"name":"message","args":["{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"read\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{}}}]}}"]}'; sleep 3; echo '5:::{"name":"message", "args":[]}') |
  websocat --max-messages=2 "wss://oulite.ouman.io/socket.io/1/websocket/$WSTOKEN?deviceid=$DEVICEID&token=$TOKEN" |
  grep -v '3:::{"jsonrpc":"2.0","method":"device_connected"' |
  grep '3:::{"jsonrpc":"2.0","id":3,"result"' |
  sed 's/3::://' |
  jq '.result.objects | .[] | .properties."85".value'
