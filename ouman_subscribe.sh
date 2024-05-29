#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH -i dash -I channel:nixos-23.11-small -p dash websocat cacert curl jq nix gnugrep gnused
set -eu

object=$1

. ./ouman_env.sh

./ouman_login.sh

export DEVICEID=$(cat "/tmp/ouman-$USER/headers" | tail -n-1)
export TOKEN=$(cat "/tmp/ouman-$USER/headers" | head -n-1)

. ./ouman_objects.sh "$object"

{
  echo "40{\"deviceid\":\"$DEVICEID\",\"date\":\"$(date -u '+%Y-%m-%dT%H:%M:%S.000Z')\",\"token\":\"$TOKEN\"}"
  sleep 1
  echo '42["message","{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"subscribe\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{}}}]}}"]'
} |
  websocat -n "wss://oulite.ouman.io/socket.io/?EIO=4&transport=websocket" |
  grep --line-buffered -v '42.*device_connected' |
  grep --line-buffered -v '42.*result' |
  grep --line-buffered '42.*params' |
  sed 's/^42."message","\(.*\)"]/\1/' |
  tr -d '\\' |
  jq '.params.objects | .[] | .properties."85".value'
