#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq flock findutils nix gnugrep gnused bkt
set -eu

object=$1

dash ./ouman_login.sh | {
  read -r DEVICEID TOKEN

  . ./ouman_objects.sh "$object"

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

}