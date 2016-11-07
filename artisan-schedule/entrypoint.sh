#!/bin/sh
set -e

if [ ! -z "$CONFIGURE_KUBERNETES" ]; then
  while true; do
    if [ -f "/app/.initialized" ]; then
      touch /app/.kubernetes-configured
      break;
    fi

    sleep 1;
  done
fi

exec "$@"
