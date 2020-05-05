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
else
    set -ex
fi

docker build \
    -f ./../src/toolkit/Dockerfile \
    --target php-node \
    -t toolkit:latest \
    ./../src/toolkit

docker build \
    --build-arg APP_RELEASE \
    -t ${APP_NAME}:latest \
    ./..

docker rm -f ${APP_NAME} || true

entrypoint_command="set -ex"
entrypoint_command+="; npm install"
entrypoint_command+="; /var/task/node_modules/webpack/bin/webpack.js --hide-modules --config=/var/task/node_modules/laravel-mix/setup/webpack.config.js"
entrypoint_command+="; composer install -v --no-suggest --no-dev --no-interaction --no-ansi"
entrypoint_command+="; bin/up.sh"

docker run \
    --name ${APP_NAME} \
    -d \
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
    -v $PWD/../node_modules:/var/task/node_modules \
    ${APP_NAME}:latest \
    /bin/sh -c "${entrypoint_command}"

if [ "$quiet" != true ] ; then
    docker logs -f ${APP_NAME}
fi