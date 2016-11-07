#!/bin/sh
set -e

if ps aux | grep "nginx" | grep -v grep > /dev/null ; then
  exit 0
fi

exit 1
