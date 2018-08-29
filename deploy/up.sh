#!/usr/bin/env bash

set -ex

export HOST_PORT=${HOST_PORT:=80}
export CONTAINER_PORT=${CONTAINER_PORT:=80}
export COMPOSER_OPTIMIZE=${COMPOSER_OPTIMIZE:=false}
export ASSETS_OPTIMIZE=${ASSETS_OPTIMIZE:=true}
export BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED:=false}
export BASIC_AUTH_USER=${BASIC_AUTH_USER:=false}
export BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD:=false}

name='skellington'

cd "$(dirname "$0")"

docker build \
    -t ${name}:latest \
    --build-arg COMPOSER_OPTIMIZE=${COMPOSER_OPTIMIZE} \
    --build-arg ASSETS_OPTIMIZE=${ASSETS_OPTIMIZE} \
    --build-arg BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED} \
    --build-arg BASIC_AUTH_USER=${BASIC_AUTH_USER} \
    --build-arg BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD} \
    ./..

docker rm -f ${name} || true

docker run \
    --name ${name} \
    -d \
    -p ${HOST_PORT}:80 \
    ${name}:latest
