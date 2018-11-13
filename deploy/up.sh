#!/usr/bin/env bash

set -ex

cd "$(dirname "$0")"

export APP_PORT=${APP_PORT:=80}
export APP_NAME=${APP_NAME:=$(basename $(dirname $PWD))}
export APP_RELEASE=${APP_RELEASE:=$(git rev-parse HEAD)}
export OPTIMIZE_PHP=${OPTIMIZE_PHP:=true}
export OPTIMIZE_COMPOSER=${OPTIMIZE_COMPOSER:=true}
export OPTIMIZE_ASSETS=${OPTIMIZE_ASSETS:=true}
export BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED:=true}
export BASIC_AUTH_USERNAME=${BASIC_AUTH_USERNAME:=admin}
export BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD:=${APP_NAME}_password}
export XDEBUG_ENABLED=${XDEBUG_ENABLED:=false}
export XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST:=10.254.254.254}
export XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT:=9000}
export XDEBUG_IDE_KEY=${XDEBUG_IDE_KEY:=${APP_NAME}_PHPSTORM}

docker build \
    --build-arg APP_RELEASE \
    -t ${APP_NAME}:latest \
    ./..

docker rm -f ${APP_NAME} || true

docker run \
    --name ${APP_NAME} \
    -d \
    -p ${APP_PORT}:80 \
    -e APP_PORT \
    -e APP_NAME \
    -e OPTIMIZE_PHP \
    -e OPTIMIZE_COMPOSER \
    -e OPTIMIZE_ASSETS \
    -e BASIC_AUTH_ENABLED \
    -e BASIC_AUTH_USERNAME \
    -e BASIC_AUTH_PASSWORD \
    -e XDEBUG_ENABLED \
    -e XDEBUG_REMOTE_HOST \
    -e XDEBUG_REMOTE_PORT \
    -e XDEBUG_IDE_KEY \
    ${APP_NAME}:latest
