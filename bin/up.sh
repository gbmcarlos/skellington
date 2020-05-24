#!/usr/bin/env bash

# Check whether processes are still alive and if one of them has crashed or exited stop
# Process manager inspired by https://github.com/formapro/docker-nginx-php-fpm
TRAPPED_SIGNAL=false

echo 'Starting NGINX';
nginx \
    -g 'daemon off;' \
    -c /etc/nginx/nginx.conf \
    2>&1 &
NGINX_PID=$!

echo 'Starting PHP-FPM';
php-fpm \
    --allow-to-run-as-root \
    --nodaemonize \
    --fpm-config "/var/task/php-fpm/conf.d/php-fpm.ini" \
    2>&1 &
PHP_FPM_PID=$!

trap "TRAPPED_SIGNAL=true; kill -15 ${NGINX_PID}; kill -15 ${PHP_FPM_PID};" SIGTERM SIGINT

echo ${APP_NAME} 'is ready. Listening at port' ${APP_PORT};

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
