#!/usr/bin/env bash

# This script will be run inside the running container to compile the assets

set -ex

export APP_DEBUG=${APP_DEBUG:=true}

echo ">>>> Compile SASS and JS"

cd /var/www

if [ $APP_DEBUG = "true" ] ; then
    if [[ $1 == watch ]] ; then
        node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js --watch
    else
        node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js
    fi
else
    node_modules/webpack/bin/webpack.js --hide-modules -p --config=node_modules/laravel-mix/setup/webpack.config.js
fi
