#!/bin/sh
set -e

if [[ -n "$BEANSTALKD_HOST" ]]; then
  if [[ -z "$BEANSTALKD_PORT" ]]; then
    BEANSTALKD_PORT=11300
  fi

  sed -ir "s/'servers'.*$/'servers' => array('default' => 'beanstalk:\/\/$BEANSTALKD_HOST:$BEANSTALKD_PORT'),/g" /app/config.php
elif [[ -n "$BEANSTALKD_PORT_11300_TCP_ADDR" ]]; then
  BEANSTALKD_HOST=$BEANSTALKD_PORT_11300_TCP_ADDR

  if [[ -z "$BEANSTALKD_PORT" ]]; then
    if [[ -n "$BEANSTALKD_PORT_11300_TCP_PORT" ]]; then
      BEANSTALKD_PORT=$BEANSTALKD_PORT_11300_TCP_PORT
    fi
  else
    BEANSTALKD_PORT=11300
  fi

  sed -ir "s/'servers'.*$/'servers' => array('default' => 'beanstalk:\/\/$BEANSTALKD_HOST:$BEANSTALKD_PORT'),/g" /app/config.php
fi

if [[ -n "$ADMIN_USERNAME" ]]; then
  sed -ir "s/'enabled'.*$/'enabled' => true,/g" /app/config.php
  sed -ir "s/'username'.*$/'username' => '$ADMIN_USERNAME',/g" /app/config.php
fi

if [[ -n "$ADMIN_PASSWORD" ]]; then
  sed -ir "s/'enabled'.*$/'enabled' => true,/g" /app/config.php
  sed -ir "s/'password'.*$/'password' => '$ADMIN_PASSWORD',/g" /app/config.php
fi

exec "$@"
