SHELL := /bin/bash
.DEFAULT_GOAL := standalone
.PHONY: standalone test

MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
PROJECT_PATH := $(dir ${MAKEFILE_PATH})
PROJECT_NAME := $(notdir $(patsubst %/,%,$(dir ${PROJECT_PATH})))

export APP_PORT ?= 80
export APP_NAME ?= ${PROJECT_NAME}
export APP_RELEASE ?= latest
export BASIC_AUTH_ENABLED ?= false
export BASIC_AUTH_USERNAME ?= admin
export BASIC_AUTH_PASSWORD ?= ${APP_NAME}_password
export XDEBUG_ENABLED ?= true
export XDEBUG_REMOTE_HOST ?= host.docker.internal
export XDEBUG_REMOTE_PORT ?= 10000
export XDEBUG_IDE_KEY ?= ${APP_NAME}_PHPSTORM

ENTRYPOINT_COMMAND := set -ex
ENTRYPOINT_COMMAND += ; npm install
ENTRYPOINT_COMMAND += ; /var/task/node_modules/webpack/bin/webpack.js --hide-modules --config=/var/task/node_modules/laravel-mix/setup/webpack.config.js
ENTRYPOINT_COMMAND += ; composer install -v --no-suggest --no-dev --no-interaction --no-ansi
ENTRYPOINT_COMMAND += ; bin/up.sh

standalone: toolkit/laravel
	docker build -t ${APP_NAME} .

	docker rm -f ${APP_NAME} || true

	docker run \
    --name ${APP_NAME} \
    -d \
    -p ${APP_PORT}:80 \
    -e APP_PORT \
    -e APP_NAME \
    -e BASIC_AUTH_ENABLED \
    -e BASIC_AUTH_USERNAME \
    -e BASIC_AUTH_PASSWORD \
    -e XDEBUG_ENABLED \
    -e XDEBUG_REMOTE_HOST \
    -e XDEBUG_REMOTE_PORT \
    -e XDEBUG_IDE_KEY \
    -v ${PROJECT_PATH}/src:/var/task/src \
    -v ${PROJECT_PATH}/vendor:/var/task/vendor \
    -v ${PROJECT_PATH}/node_modules:/var/task/node_modules \
    ${APP_NAME}:latest \
    /bin/sh -c "${ENTRYPOINT_COMMAND}"

	docker logs -f ${APP_NAME}

watch-assets:
	docker exec \
    -it \
    ${APP_NAME} \
    /bin/sh -c "/var/task/node_modules/webpack/bin/webpack.js --hide-modules --config=/var/task/node_modules/laravel-mix/setup/webpack.config.js --watch"

run: toolkit/laravel
	docker build -t ${APP_NAME} .

	docker run \
    --name ${APP_NAME}-bg \
    --rm \
    -it \
    -e APP_NAME \
    -e XDEBUG_ENABLED \
    -e XDEBUG_REMOTE_HOST \
    -e XDEBUG_REMOTE_PORT \
    -e XDEBUG_IDE_KEY \
    -v ${PROJECT_PATH}/src:/var/task/src \
    -v ${PROJECT_PATH}/vendor:/var/task/vendor \
    -v ${PROJECT_PATH}/node_modules:/var/task/node_modules \
    ${APP_NAME}:latest \
    /bin/sh -c "composer install -v --no-suggest --no-dev --no-interaction --no-ansi && php src/server.php ${ARGS}"

toolkit/laravel:
	cd src/toolkit/Docker ; make laravel