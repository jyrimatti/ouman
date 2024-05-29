#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep OUMAN_USER --keep OUMAN_PASSWORD -i dash -I channel:nixos-23.11-small -p dash cacert websocat curl jq nix gnugrep gnused
set -eu

object=$1

./ouman_login.sh

export DEVICEID="$(cat "/tmp/ouman-$USER/headers" | tail -n-1)"
export TOKEN="$(cat "/tmp/ouman-$USER/headers" | head -n-1)"

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

tmpfile="$(mktemp -u)"
mkfifo "$tmpfile"
trap "rm $tmpfile" EXIT
ret="$(
{
  echo "40{\"deviceid\":\"$DEVICEID\",\"date\":\"$(date -u '+%Y-%m-%dT%H:%M:%S.000Z')\",\"token\":\"$TOKEN\"}"
  while read -r line; do
    #echo "$line" >&2
    case $line in
      '42["message","{\"jsonrpc\":\"2.0\",\"method\":\"device_connected\"'*)
        #echo "Sending first" >&2
        echo '42["message","{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"read\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{}}}]}}"]';
        ;;
      '42["message","{\"jsonrpc\":\"2.0\",\"id\"'*)
        #echo "Got response, breaking..." >&2
        break;
        ;;
    esac
  done < "$tmpfile"
} |
  websocat -v "wss://oulite.ouman.io/socket.io/?EIO=4&transport=websocket" 2>&1 | tee "$tmpfile" | grep -v '^\['
)" 2>/dev/null # 'Abort trap: 6' >/dev/null

echo "$ret" | {
  grep -v '42.*device_connected' |
  grep '42.*result' |
  sed 's/^42."message","\(.*\)"]/\1/' |
  tr -d '\\' |
  jq '.result.objects | .[] | .properties."85".value'
} | head -n1 # keep only first since sometimes we get multiple response values...