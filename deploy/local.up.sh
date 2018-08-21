#!/usr/bin/env bash

set -ex

export HOST_PORT=${HOST_PORT:=80}
export CONTAINER_PORT=${CONTAINER_PORT:=8080}
export COMPOSER_OPTIMIZE=${COMPOSER_OPTIMIZE:=false}
export ASSETS_OPTIMIZE=${ASSETS_OPTIMIZE:=true}

name='skellington'

cd "$(dirname "$0")"

docker build \
    -t ${name}:latest \
    --build-arg CONTAINER_PORT=${CONTAINER_PORT} \
    --build-arg COMPOSER_OPTIMIZE=${COMPOSER_OPTIMIZE} \
    --build-arg ASSETS_OPTIMIZE=${ASSETS_OPTIMIZE} \
    ./..

docker rm -f ${name} || true

docker run \
    --name ${name} \
    -d \
    -p ${HOST_PORT}:${CONTAINER_PORT} \
    -v $PWD/../src:/var/www/src \
    -v $PWD/../vendor:/var/www/vendor \
    -v $PWD/../node_modules:/var/www/node_modules \
    ${name}:latest \
    /bin/sh -c "cd /var/www && php composer.phar install -v --working-dir=/var/www --no-suggest --no-dev && npm install && node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js && apache2ctl -D FOREGROUND"

docker logs -f ${name}
