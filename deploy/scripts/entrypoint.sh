#!/usr/bin/env bash

export APP_PORT=${APP_PORT:=80}
export APP_NAME=${APP_NAME=localhost}
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

# Configure according to the OPTIMIZE_ BASIC_AUTH_ and XDEBUG_ env vars
/bin/sh ./configure.sh

# Check whether processes are still alive and if one of them has crashed or exited stop
# Process manager inspired by https://github.com/formapro/docker-nginx-php-fpm
TRAPPED_SIGNAL=false

echo 'Starting NGINX';
nginx \
    -g 'daemon off;' \
    -c /usr/local/etc/nginx.conf \
    2>&1 &
NGINX_PID=$!

echo 'Starting PHP-FPM';
php-fpm \
    --allow-to-run-as-root \
    --nodaemonize \
    --fpm-config /usr/local/etc/php-fpm.conf \
    -c /usr/local/etc/php.ini \
    2>&1 &
PHP_FPM_PID=$!

trap "TRAPPED_SIGNAL=true; kill -15 ${NGINX_PID}; kill -15 ${PHP_FPM_PID};" SIGTERM SIGINT

echo ${APP_NAME} 'ready. Listening at port' ${APP_PORT};

#
while :
do
    kill -0 ${NGINX_PID} 2> /dev/null
    NGINX_STATUS=$?

    kill -0 ${PHP_FPM_PID} 2> /dev/null
    PHP_FPM_STATUS=$?

    if [ "$TRAPPED_SIGNAL" = "false" ]; then
        if [ ${NGINX_STATUS} -ne 0 ] || [ ${PHP_FPM_STATUS} -ne 0 ]; then
            if [ ${NGINX_STATUS} -eq 0 ]; then
                kill -15 ${NGINX_PID};
                wait ${NGINX_PID};
            fi
            if [ ${PHP_FPM_STATUS} -eq 0 ]; then
                kill -15 ${PHP_FPM_PID};
                wait ${PHP_FPM_PID};
            fi

            exit 1;
        fi
    else
       if [ ${NGINX_STATUS} -ne 0 ] && [ ${PHP_FPM_STATUS} -ne 0 ]; then
            exit 0;
       fi
    fi

	sleep 1
done
