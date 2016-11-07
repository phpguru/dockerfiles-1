#!/bin/sh
set -e

if ps aux | grep "crond" | grep -v grep > /dev/null ; then
  exit 0
fi

exit 1
