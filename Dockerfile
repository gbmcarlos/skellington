FROM gbmcarlos/php-api as app

FROM lambci/lambda:provided as lambda

## Base PHP Layer
## Project vendor Layer
COPY --from=app /opt /opt/

## Function code
COPY --from=app /var/task /var/task

ENV APP_NAME=localhost \
    XDEBUG_ENABLED=false \
    XDEBUG_REMOTE_HOST=host.docker.internal \
    XDEBUG_REMOTE_PORT=10000 \
    XDEBUG_IDE_KEY=${APP_NAME}"_PHPSTORM" \
    MEMORY_LIMIT="128M"
