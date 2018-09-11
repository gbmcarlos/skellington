FROM php:7.2-fpm-alpine

LABEL maintainer="gbmcarlos@gmail.com"

## SYSTEM DEPENDENCIES
### vim and bash are utilities, so that we can work inside the container
### apache2-utils is necessary to use htpasswd to encrypt the password for basic auth
### $PHPIZE_DEPS contains the dependencies to use phpize, which is required to install with pecl
### supervisor, nginx and node+npm are part of the stack
RUN     apk update \
    &&  apk add \
            bash \
            vim \
            apache2-utils \
            supervisor \
            nginx \
            nodejs nodejs-npm \
            $PHPIZE_DEPS

## PHP EXTENSION
### Install both opcache and xdebug regardles of the environment (regardless of the env vars), they will be enabled or disabled later
RUN     set -ex \
    &&  pecl install \
            xdebug-2.6.1 \
    &&  docker-php-ext-enable \
            xdebug \
    &&  docker-php-ext-install \
            pdo \
            pdo_mysql \
            opcache

## NPM INSTALL
COPY ./package.* /var/www/
RUN npm install

## COMPOSER INSTALL
### Not autolader, it will be created later on
COPY ./composer.* /var/www/
RUN php /var/www/composer.phar install -v --working-dir=/var/www --no-autoloader --no-suggest --no-dev

## CONFIGURATION FILES
### php, php-fpm, nginx and supervisor config files
COPY ./deploy/scripts/php.ini /usr/local/etc/php/php.ini
COPY ./deploy/scripts/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./deploy/scripts/nginx.conf /etc/nginx/nginx.conf
COPY ./deploy/scripts/supervisor.conf /etc/supervisor.conf

## CONFIGURE PHP
### https://secure.php.net/manual/en/opcache.installation.php#opcache.installation.recommended
### If OPTIMIZE_PHP, set the error reporting settings and the setting OPCache
### If not OPTIMIZE_PHP, set the error reporting settings and delete the .ini config file for OPCache that was created by the docker-php-ext-install script
ARG OPTIMIZE_PHP=false
RUN if \
        [ $OPTIMIZE_PHP = "true" ] ; \
    then \
            echo $'\n\
display_errors=Off\n\
display_startup_errors=Off\n\
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT\n\
mysqlnd.collect_memory_statistics = Off\n\
zend.assertions = -1\n\
log_errors=On' >> /usr/local/etc/php/php.ini \
        &&  echo $'\n\
opcache.memory_consumption=Off\n\
opcache.interned_strings_buffer=Off\n\
opcache.max_accelerated_files=Off\n\
opcache.revalidate_freq=Off\n\
opcache.fast_shutdown=Off\n\
opcache.enable_cli=On' >> /usr/local/etc/php/conf.d/opcache.ini; \
    else \
            echo $'\n\
display_errors=STDOUT\n\
display_startup_errors=On\n\
error_reporting=E_ALL\n\
mysqlnd.collect_memory_statistics=Off\n\
zend.assertions=1\n\
log_errors=On' >> /usr/local/etc/php/php.ini \
        &&  rm /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini; \
    fi

## www user for nginx and php-fpm to share
RUN adduser -D -g 'www' www

## SOURCE CODE
COPY ./src /var/www/src

WORKDIR /var/www

# storage folder permissions
#RUN chown -R www:www src/storage

## COMPOSER AUTOLOADER
ARG OPTIMIZE_COMPOSER=false
RUN if \
        [ $OPTIMIZE_COMPOSER = "true" ] ; \
    then \
        php composer.phar dump-autoload -v --optimize --classmap-authoritative; \
    else \
        php composer.phar dump-autoload -v; \
    fi

## AGGREGATE ASSETS
COPY ./webpack.mix.js webpack.mix.js
ARG OPTIMIZE_ASSETS=false
RUN if \
        [ $OPTIMIZE_ASSETS = "true" ] ; \
    then \
        node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js -p; \
    else \
        node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js; \
    fi

CMD ["supervisord", "-n", "-c", "/etc/supervisor.conf"]