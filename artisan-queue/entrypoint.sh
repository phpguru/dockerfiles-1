#!/bin/sh
set -e

if [ ! -z "$CONFIGURE_KUBERNETES" ]; then
  while true; do
    if [ -f "/app/.initialized" ]; then
      sed -i -e "s/CACHE_DRIVER=.*/CACHE_DRIVER=file/g" /app/.env
      touch /app/.kubernetes-configured
      break;
    fi

    sleep 1;
  done
fi

exec "$@"
