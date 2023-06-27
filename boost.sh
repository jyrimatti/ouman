#!/bin/bash
set -eu

getset=$1
value=${4:-}
if [ "$value" == "true" ]; then
  value="3";
else
  value="2";
fi

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$getset" == "Set" ]; then
  $scripts/ouman_post.sh fanSpeedMode_ $value "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
else
  $scripts/ouman_get.sh fanSpeedMode_ "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
fi
