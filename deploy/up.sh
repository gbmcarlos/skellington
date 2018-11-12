#!/usr/bin/env bash

set -ex

cd "$(dirname "$0")"

export HOST_PORT=${HOST_PORT:=80}
export PROJECT_NAME=${PROJECT_NAME:=$(basename $(dirname $PWD))}
export OPTIMIZE_PHP=${OPTIMIZE_PHP:=true}
export OPTIMIZE_COMPOSER=${OPTIMIZE_COMPOSER:=true}
export OPTIMIZE_ASSETS=${OPTIMIZE_ASSETS:=true}
export BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED:=true}
export BASIC_AUTH_USERNAME=${BASIC_AUTH_USERNAME:=admin}
export BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD:=${PROJECT_NAME}_password}
export XDEBUG_ENABLED=${XDEBUG_ENABLED:=false}
export XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST:=10.254.254.254}
export XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT:=9000}
export XDEBUG_IDE_KEY=${XDEBUG_IDE_KEY:=${PROJECT_NAME}_PHPSTORM}

docker build \
    -t ${PROJECT_NAME}:latest \
    ./..

docker rm -f ${PROJECT_NAME} || true

docker run \
    --name ${PROJECT_NAME} \
    -d \
    -p ${HOST_PORT}:80 \
    -e HOST_PORT \
    -e PROJECT_NAME \
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
    ${PROJECT_NAME}:latest
