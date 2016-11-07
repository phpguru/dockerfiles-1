#!/usr/bin/env bash

VERSION=`bash --version | head -n1 | awk '{print $4}'`
if [[ ${VERSION} != 4* ]]
then
  echo "Requires Bash 4+. Run \`brew install bash\`. (Installed: $VERSION)" 1>&2
  exit 1
fi

declare -a IMAGES=(
  "baseimage:3.4"
  "php:7.0.12"
  "php-fpm:7.0.12"
  "artisan-queue:7.0.12"
  "artisan-schedule:7.0.12"
  "beanstalkd:1.10"
  "beanstalkd-console:1.7.5"
  "nginx:1.11.5"
  "ngrok:2.1.14"
)

for i in "${!IMAGES[@]}"
do
  IFS=':' read -a IMAGE <<< ${IMAGES[$i]}

  NAME=${IMAGE[0]}
  VERSION=${IMAGE[1]}

  if [[ ! -z ${1+x} && $1 != $NAME ]]
  then
    continue
  fi

  echo "==> Building ${IMAGES[$i]}"
  docker build -t ellisio/$NAME ./$NAME/
  docker tag ellisio/$NAME:latest ellisio/$NAME:$VERSION

  if [[ -z "$2" ]]; then
    docker push ellisio/$NAME:latest
    docker push ellisio/$NAME:$VERSION
  fi
done

exit 0
