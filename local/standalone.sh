#!/usr/bin/env bash

cd "$(dirname "$0")"

export APP_PORT=${APP_PORT:=80}
export APP_NAME=${APP_NAME:=$(basename $(dirname $PWD))}
export APP_RELEASE=${APP_RELEASE:=latest}
export BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED:=false}
export BASIC_AUTH_USERNAME=${BASIC_AUTH_USERNAME:=admin}
export BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD:=${APP_NAME}_password}
export XDEBUG_ENABLED=${XDEBUG_ENABLED:=true}
export XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST:=host.docker.internal}
export XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT:=10000}
export XDEBUG_IDE_KEY=${XDEBUG_IDE_KEY:=${APP_NAME}_PHPSTORM}

if [ "$1" == "--quiet" ]; then
	quiet=true
fi

set -ex

docker build \
    -f ./../src/toolkit/Dockerfile \
    -t toolkit:latest \
    ./../src/toolkit

docker build \
    --build-arg APP_RELEASE \
    -t ${APP_NAME}:latest \
    ./..

docker rm -f ${APP_NAME} || true

docker run \
    --name ${APP_NAME} \
    -it \
    -p ${APP_PORT}:80 \
    -e APP_DEBUG=true \
    -e APP_PORT \
    -e APP_NAME \
    -e BASIC_AUTH_ENABLED \
    -e BASIC_AUTH_USERNAME \
    -e BASIC_AUTH_PASSWORD \
    -e XDEBUG_ENABLED \
    -e XDEBUG_REMOTE_HOST \
    -e XDEBUG_REMOTE_PORT \
    -e XDEBUG_IDE_KEY \
    -v $PWD/../src:/var/task/src \
    -v $PWD/../vendor:/var/task/vendor \
    ${APP_NAME}:latest \
    /bin/sh -c "set -ex && composer install -v --no-suggest --no-dev --no-interaction --no-ansi && bin/up.sh"

if [ "$quiet" != true ] ; then
    docker logs -f ${APP_NAME}
fi