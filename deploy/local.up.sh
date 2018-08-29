#!/usr/bin/env bash

set -ex

export HOST_PORT=${HOST_PORT:=80}
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
    -v $PWD/../src:/var/www/src \
    -v $PWD/../vendor:/var/www/vendor \
    -v $PWD/../node_modules:/var/www/node_modules \
    ${name}:latest \
    /bin/sh -c "cd /var/www && php composer.phar install -v --working-dir=/var/www --no-suggest --no-dev && npm install && node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js && apache2ctl -D FOREGROUND"

docker logs -f ${name}
