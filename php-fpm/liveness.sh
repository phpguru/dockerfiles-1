#!/bin/sh
set -e

if ps aux | grep "php-fpm" | grep -v grep > /dev/null ; then
  exit 0
fi

exit 1
