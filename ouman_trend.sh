#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash websocat cacert curl jq gnugrep gnused bkt
set -eu

object=$1
date=$2

dash ./ouman_login.sh | {
  read -r DEVICEID TOKEN

  DATE1="$(date '+%C%y-%m-%d %H:%M:%S' -d "$date")"
  DATE2="${3:-$(date '+%C%y-%m-%d %H:%M:%S' -d "$DATE1 +1 day")}"

  . ./ouman_objects.sh "$object"

  {
    echo "40{\"deviceid\":\"$DEVICEID\",\"date\":\"$(date -u '+%Y-%m-%dT%H:%M:%S.000Z')\",\"token\":\"$TOKEN\"}"
    sleep 1
    echo '42["message","{\"jsonrpc\":\"2.0\",\"id\":3,\"method\":\"readtrend2\",\"params\":{\"objects\":[{\"starttime\":\"'"$DATE1"'\",\"endtime\":\"'"$DATE2"'\",\"id\":\"'"$OBJECTID"'\",\"device\":255}]}}"]'
  } |
    websocat -n --max-messages-rev=4 -B512000 "wss://oulite.ouman.io/socket.io/?EIO=4&transport=websocket" |
    grep -v '42.*device_connected' |
    grep '42.*trenddata' |
    sed 's/^42."message","\(.*\)"]/\1/' |
    tr -d '\\' |
    jq '.result.objects | .[] | .trenddata' |
    tr -d '"' |
    tr '@' '\n' |
    grep '[^ ]' |
    uniq

}