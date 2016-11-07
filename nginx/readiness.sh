#!/bin/sh
set -e

if [ -f "/app/.initialized" ]; then
  if [ ! -z "$CONFIGURE_KUBERNETES" ] && [ ! -f "/app/.kubernetes-configured" ]; then
    exit 1
  fi

  exit 0
fi

exit 1
