#!/bin/bash
set -eu

getset=$1
value=${4:-}
if [ "$value" == "true" ]; then
  value="2"; # COMFORT (summer)
else
  value="1"; # ECO (winter)
fi

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$getset" == "Set" ]; then
  $scripts/ouman_post.sh heatingMode $value "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
else
  $scripts/ouman_get.sh heatingMode "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
fi
