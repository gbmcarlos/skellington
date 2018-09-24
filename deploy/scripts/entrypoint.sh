#!/usr/bin/env bash

export PROJECT_NAME=${PROJECT_NAME=localhost}
export OPTIMIZE_PHP=${OPTIMIZE_PHP:=true}
export OPTIMIZE_COMPOSER=${OPTIMIZE_COMPOSER:=true}
export OPTIMIZE_ASSETS=${OPTIMIZE_ASSETS:=true}
export BASIC_AUTH_ENABLED=${BASIC_AUTH_ENABLED:=true}
export BASIC_AUTH_USER=${BASIC_AUTH_USER:=admin}
export BASIC_AUTH_PASSWORD=${BASIC_AUTH_PASSWORD:=${PROJECT_NAME}_password}
export XDEBUG_ENABLED=${XDEBUG_ENABLED:=false}
export XDEBUG_REMOTE_HOST=${XDEBUG_REMOTE_HOST:=10.254.254.254}
export XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT:=9000}
export XDEBUG_IDE_KEY=${XDEBUG_IDE_KEY:=${PROJECT_NAME}_PHPSTORM}

# Configure according to the OPTIMIZE_ BASIC_AUTH_ and XDEBUG_ env vars
/bin/sh /var/www/configure.sh

# Start supervisord. This will, in turn, start php-fpm and nginx
supervisord -n -c /etc/supervisor.conf