FROM php:7.2-fpm-alpine3.8

LABEL maintainer="gbmcarlos@gmail.com"

## SYSTEM DEPENDENCIES
### vim and bash are utilities, so that we can work inside the container
### apache2-utils is necessary to use htpasswd to encrypt the password for basic auth
### gettext is necessary to replace environment variables in the nginx config file at run time, for the basic auth
### supervisor, nginx and node+npm are part of the stack
### $PHPIZE_DEPS contains the dependencies to use phpize, which is required to install with pecl
RUN     apk update \
    &&  apk add \
            bash vim \
            gettext apache2-utils \
            supervisor nginx=1.14.0-r1 \
            nodejs=8.11.4-r0 nodejs-npm=8.11.4-r0 \
            $PHPIZE_DEPS

## PHP EXTENSIONS
### Install xdebug but don't enable it, it will be enabled at run time if needed
RUN     set -ex \
    &&  pecl install \
            xdebug-2.6.1 \
    &&  docker-php-ext-install \
            pdo_mysql \
            opcache

WORKDIR /var/www

## NPM
COPY ./package* ./
RUN npm install

## COMPOSER
### Install composer by copying the binary from composer's official image (compressed multi-stage)
### So far, we are just going to install the dependencies, so no need to dump the autoloader yet
### At the end, remove the root's composer folder that was used to install and use prestissimo
COPY --from=composer:1.7.2 /usr/bin/composer /usr/bin/composer
COPY ./composer.* ./
RUN     composer global require hirak/prestissimo:0.3.8 \
    &&  composer install -v --no-autoloader --no-suggest --no-dev --no-interaction --no-ansi \
    &&  rm -rf /root/.composer

## SOURCE CODE
COPY ./src ./src

## PERMISSIONS
### Create www user and group for nginx
### Set the permission for the temp folder of nginx
### Set permission for the storage folder
RUN     adduser -D -g 'www' www \
    &&  chown -R www:www /var/tmp/nginx \
    &&  chown -R www:www src/storage \
    &&  chown -R www:www src/bootstrap/cache

## COMPOSER AUTOLOADER
### Now that we've copied the source code, dump the autoloader
### By default, optimize the autoloader
RUN composer dump-autoload -v --classmap-authoritative --no-dev --no-interaction --no-ansi

## AGGREGATE ASSETS
### By default, optimize the aggregation of assets
COPY ./webpack.mix.js webpack.mix.js
RUN node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js -p

## CONFIGURATION FILES
### php, php-fpm, nginx and supervisor config files
COPY ./deploy/config/php.ini /usr/local/etc/php/php.ini
COPY ./deploy/config/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./deploy/config/nginx.conf /etc/nginx/nginx.conf
COPY ./deploy/config/supervisor.conf /etc/supervisor.conf

## SCRIPTS
### Make sure all scripts have execution permissions
COPY ./deploy/scripts/* ./
RUN chmod +x ./*.sh

EXPOSE 80

CMD ["./entrypoint.sh"]
