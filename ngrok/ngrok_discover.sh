#!/bin/sh

if [ "$1" = "/bin/sh" ]; then
  shift
fi

if [ -n "$HTTPS_PORT" ]; then
  FWD="`echo $HTTPS_PORT | sed 's|^tcp://||'`"
elif [ -n "$HTTP_PORT" ]; then
  FWD="`echo $HTTP_PORT | sed 's|^tcp://||'`"
elif [ -n "$1" ]; then
  FWD="$1"
else
  echo "Must be run with a link aliased to http or https, an environmental variable (HTTP_PORT), or passed as a command."
  echo "=> Example: docker run --link app:http ellisio/ngrok"
  echo "=> Example: docker run -e HTTP_PORT 8080 ellisio/ngrok"
  echo "=> Example: docker run ellisio/ngrok 80"
  exit 1
fi

case "$1" in
  -h|help)  ARGS=$1 ;;
  *)        ARGS="--config /ngrok.yml -subdomain=$NGROK_SUBDOMAIN $FWD" ;;
esac

sed -i "s/^authtoken:.*/authtoken: $NGROK_TOKEN/g" /ngrok.yml
exec /bin/ngrok http $ARGS
