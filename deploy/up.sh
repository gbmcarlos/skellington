#!/usr/bin/env bash

set -ex

export HOST_PORT=${HOST_PORT:=80}
export CONTAINER_PORT=${CONTAINER_PORT:=8080}
export COMPOSER_OPTIMIZE=${COMPOSER_OPTIMIZE:=true}

name='skellington'

cd "$(dirname "$0")"

docker build \
    -t ${name}:latest \
    --build-arg CONTAINER_PORT=${CONTAINER_PORT} \
    --build-arg COMPOSER_OPTIMIZE=${COMPOSER_OPTIMIZE} \
    ./..

docker rm -f ${name} || true

docker run \
    --name ${name} \
    -d \
    -p ${HOST_PORT}:${CONTAINER_PORT} \
    ${name}:latest
