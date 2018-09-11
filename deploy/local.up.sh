#!/usr/bin/env bash

set -ex

cd "$(dirname "$0")"

# Set the name of the project root folder as the default value for PROJECT_NAME
export PROJECT_NAME=${PROJECT_NAME:=$(basename $(dirname $PWD))}

export HOST_PORT=${HOST_PORT:=81}
export OPTIMIZE_PHP=${OPTIMIZE_PHP:=false}
export OPTIMIZE_COMPOSER=${OPTIMIZE_COMPOSER:=false}
export OPTIMIZE_ASSETS=${OPTIMIZE_ASSETS:=false}
export BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED:=false}
export BASIC_AUTH_USER=${BASIC_AUTH_USER:=admin}
export BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD:=${PROJECT_NAME}_password}
export XDEBUG_ENABLED=${XDEBUG_ENABLED:=true}
export XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST:=10.254.254.254}
export XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT:=9000}
export XDEBUG_IDE_KEY=${XDEBUG_IDE_KEY:=${PROJECT_NAME}_PHPSTORM}

docker build \
    -t ${PROJECT_NAME}:latest \
    --build-arg OPTIMIZE_PHP=${OPTIMIZE_PHP} \
    --build-arg OPTIMIZE_COMPOSER=${OPTIMIZE_COMPOSER} \
    --build-arg OPTIMIZE_ASSETS=${OPTIMIZE_ASSETS} \
    --build-arg BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED} \
    --build-arg BASIC_AUTH_USER=${BASIC_AUTH_USER} \
    --build-arg BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD} \
    --build-arg XDEBUG_ENABLED=${XDEBUG_ENABLED} \
    --build-arg XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST} \
    --build-arg XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT} \
    --build-arg XDEBUG_IDE_KEY=${XDEBUG_IDE_KEY} \
    ./..

docker rm -f ${PROJECT_NAME} || true

docker run \
    --name ${PROJECT_NAME} \
    -d \
    -p ${HOST_PORT}:80 \
    -v $PWD/../src:/var/www/src \
    -v $PWD/../vendor:/var/www/vendor \
    -v $PWD/../node_modules:/var/www/node_modules \
    ${PROJECT_NAME}:latest \


docker logs -f ${PROJECT_NAME}
