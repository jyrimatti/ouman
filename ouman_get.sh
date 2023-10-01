#! /usr/bin/env nix-shell
#! nix-shell --pure --keep OUMAN_USER --keep OUMAN_PASSWORD -i dash -I channel:nixos-23.05-small -p dash cacert websocat curl jq nix gnugrep gnused
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

WSTOKEN="$(curl -s "https://oulite.ouman.io/socket.io/1/?deviceid=$DEVICEID&token=$TOKEN" | sed 's/\([^:]*\):.*/\1/g')"

tmpfile="$(mktemp -u)"
mkfifo "$tmpfile"
trap "rm $tmpfile" EXIT
ret="$(
{
  while read -r line; do
    #echo "$line" >&2
    case $line in
      '3:::{"jsonrpc":"2.0","method":"device_connected"'*)
        #echo "Sending first" >&2
        echo '5:::{"name":"message","args":["{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"read\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{}}}]}}"]}';
        ;;
      '3:::{"jsonrpc":"2.0","id"'*)
        #echo "Got response, breaking..." >&2
        break;
        ;;
    esac
  done < "$tmpfile"
} |
  websocat -v "wss://oulite.ouman.io/socket.io/1/websocket/$WSTOKEN?deviceid=$DEVICEID&token=$TOKEN" 2>&1 | tee "$tmpfile" | grep -v '^\['
)" 2>/dev/null # 'Abort trap: 6' >/dev/null

echo "$ret" | {
  grep -v '3:::{"jsonrpc":"2.0","method":"device_connected"' |
  grep '3:::{"jsonrpc":"2.0","id":3,"result"' |
  sed 's/3::://' |
  jq '.result.objects | .[] | .properties."85".value'
} | head -n1 # keep only first since sometimes we get multiple response values...