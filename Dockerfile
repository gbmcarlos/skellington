FROM toolkit/stack/lumen as app

FROM lambci/lambda:provided as lambda

### Copy PHP and Composer binaries and config files
COPY --from=app /opt /opt

### Copy the source to the task folder
COPY --from=app /var/task /var/task

ENV APP_NAME=localhost \
    XDEBUG_ENABLED=false \
    XDEBUG_REMOTE_HOST=host.docker.internal \
    XDEBUG_REMOTE_PORT=10000 \
    XDEBUG_IDE_KEY=${APP_NAME}"_PHPSTORM" \
    MEMORY_LIMIT="128M"