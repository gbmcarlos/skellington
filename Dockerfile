FROM gbmcarlos/stacks:php-api as app

FROM lambci/lambda:provided as lambda

## Base PHP Layer
### This layer will contain /opt/bin, /opt/bootstrao and /opt/bref
COPY --from=app /opt/bin /opt/bootstrap /opt/bref /opt/

## Project vendor Layer
### This layer will contain /opt/vendor
COPY --from=app /opt/vendor /opt/

## Function code
### This layer will contain /var/task/src and /var/task/config
COPY --from=app /var/task/src /var/task/config /var/task/

ENV APP_NAME=localhost \
    XDEBUG_ENABLED=false \
    XDEBUG_REMOTE_HOST=host.docker.internal \
    XDEBUG_REMOTE_PORT=10000 \
    XDEBUG_IDE_KEY=${APP_NAME}"_PHPSTORM" \
    MEMORY_LIMIT="128M"
