#!/bin/bash
set -eu

getset=$1
value=${4:-}
if [ "$value" == "true" ]; then
  value="1";
else
  value="0";
fi

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$getset" == "Set" ]; then
  $scripts/ouman_post.sh fireplaceFunctionOn $value "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
else
  $scripts/ouman_get.sh fireplaceFunctionActive "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
fi
