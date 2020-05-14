SHELL := /bin/bash
.DEFAULT_GOAL := standalone
.PHONY: standalone

MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
PROJECT_PATH := $(dir ${MAKEFILE_PATH})
PROJECT_NAME := $(notdir $(patsubst %/,%,$(dir ${PROJECT_PATH})))

export DOCKER_BUILDKIT ?= 1
export APP_PORT ?= 81
export APP_NAME ?= ${PROJECT_NAME}
export APP_RELEASE ?= latest
export BASIC_AUTH_ENABLED ?= false
export BASIC_AUTH_USERNAME ?= admin
export BASIC_AUTH_PASSWORD ?= ${APP_NAME}_password
export XDEBUG_ENABLED ?= true
export XDEBUG_REMOTE_HOST ?= host.docker.internal
export XDEBUG_REMOTE_PORT ?= 10000
export XDEBUG_IDE_KEY ?= ${APP_NAME}_PHPSTORM
export PHP_IDE_CONFIG ?= serverName=${APP_NAME}

standalone: toolkit/swoole
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
    -e PHP_IDE_CONFIG \
    -v ${PROJECT_PATH}/src:/var/task/src \
    -v ${PROJECT_PATH}/vendor:/var/task/vendor \
    ${APP_NAME}:latest \
    /bin/sh -c "set -ex && composer install -v --no-suggest --no-interaction --no-ansi && php /var/task/src/server.php swoole:http start"

	docker logs -f ${APP_NAME}

run: toolkit/swoole
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
    ${APP_NAME}:latest \
    /bin/sh -c "composer install -v --no-suggest --no-dev --no-interaction --no-ansi && php src/server.php ${ARGS}"

toolkit/swoole:
	cd src/toolkit/Docker ; make swoole