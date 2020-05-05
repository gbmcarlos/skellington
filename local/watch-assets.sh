#!/usr/bin/env bash

cd "$(dirname "$0")"

export APP_NAME=${APP_NAME:=$(basename $(dirname $PWD))}

set -ex

docker exec -it ${APP_NAME} /bin/sh -c "/var/task/node_modules/webpack/bin/webpack.js --hide-modules --config=/var/task/node_modules/laravel-mix/setup/webpack.config.js --watch"
