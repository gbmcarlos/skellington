FROM php:7.2-fpm-alpine3.8

LABEL maintainer="gbmcarlos@gmail.com"

## SYSTEM DEPENDENCIES
### vim and bash are utilities, so that we can work inside the container
### apache2-utils is necessary to use htpasswd to encrypt the password for basic auth
### $PHPIZE_DEPS contains the dependencies to use phpize, which is required to install with pecl
### supervisor, nginx and node+npm are part of the stack
### gettext is necessary to replace environment variables in the nginx config file at run time, for the basic auth
RUN     apk update \
    &&  apk add \
            bash \
            vim \
            gettext \
            apache2-utils \
            supervisor \
            nginx=1.14.0-r1 \
            nodejs=8.11.4-r0 \
            nodejs-npm=8.11.4-r0 \
            $PHPIZE_DEPS

## PHP EXTENSION
### Install xdebug but don't enable it, it will be enabled at run time if needed
RUN     set -ex \
    &&  pecl install \
            xdebug-2.6.1 \
    &&  docker-php-ext-install \
            pdo \
            pdo_mysql \
            opcache

## NPM INSTALL
COPY ./package.* /var/www/
RUN npm install

## COMPOSER INSTALL
### Here we are just installing the dependencies, so don't dump the autoloader yet
COPY ./composer.* /var/www/
RUN php /var/www/composer.phar install -v --working-dir=/var/www --no-autoloader --no-suggest --no-dev

## SOURCE CODE
COPY ./src /var/www/src
WORKDIR /var/www

## PERMISSIONS
### create www user and group for nginx
### set the permission for the temp folder of nginx
### set permission for the storage folder
RUN     adduser -D -g 'www' www \
    &&  chown -R www:www /var/tmp/nginx \
    &&  chown -R www:www src/storage

## COMPOSER AUTOLOADER
### Now that we've copied the source code, dump the autoloader
### By default, optimize the autoloader
RUN php /var/www/composer.phar dump-autoload -v --optimize --classmap-authoritative;

## AGGREGATE ASSETS
### by default, optimize the aggregation of assets
COPY ./webpack.mix.js webpack.mix.js
RUN node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js -p;

COPY ./deploy/scripts/entrypoint.sh entrypoint.sh

## CONFIGURATION FILES
### php, php-fpm, nginx and supervisor config files
COPY ./deploy/config/php.ini /usr/local/etc/php/php.ini
COPY ./deploy/config/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./deploy/config/nginx.conf /etc/nginx/nginx.conf
COPY ./deploy/config/supervisor.conf /etc/supervisor.conf

EXPOSE 80

CMD ["/var/www/entrypoint.sh"]