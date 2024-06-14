#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep XDG_RUNTIME_DIR --keep OUMAN_USER --keep OUMAN_PASSWORD -i dash -I channel:nixos-23.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused
set -eu

object=$1
value=$2

headers="$(dash ./ouman_login.sh)"

export DEVICEID="$(echo "$headers" | tail -n-1)"
export TOKEN="$(echo "$headers" | head -n-1)"

. ./ouman_objects.sh "$object"

{
  echo "40{\"deviceid\":\"$DEVICEID\",\"date\":\"$(date -u '+%Y-%m-%dT%H:%M:%S.000Z')\",\"token\":\"$TOKEN\"}"
  sleep 1
  echo '42["message","{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"write\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{\"value\":'"$value"'}}}]}}"]'
} |
  websocat --max-messages=2 "wss://oulite.ouman.io/socket.io/?EIO=4&transport=websocket" |
  grep -v '42.*device_connected' |
  grep '42.*result' |
  sed 's/^42."message","\(.*\)"]/\1/' |
  tr -d '\\' |
  jq '.result'
