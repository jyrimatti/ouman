#!/bin/bash
set -eu

getset=$1
object=$2
characteristic=${3:-}

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$characteristic" == "On" ]; then
  echo 1
elif [ "$getset" == "Get" ]; then
  $scripts/ouman_get.sh "$object" "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
else
  exit 1
fi