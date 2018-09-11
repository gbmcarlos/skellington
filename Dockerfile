FROM php:7.2-fpm-alpine

LABEL maintainer="gbmcarlos@gmail.com"

## vim and bash are utilities, so that we can work inside the container while debugging
RUN     apk update \
    &&  apk add \
            bash \
            vim \
            supervisor \
            nginx

## www user for nginx and php-fpm to share
RUN adduser -D -g 'www' www

### NPM install
COPY ./package.* /var/www/
RUN npm install

### Composer install
COPY ./composer.* /var/www/
RUN php /var/www/composer.phar install -v --working-dir=/var/www --no-autoloader --no-suggest --no-dev

# Copy php-fpm, nginx and supervisor config files
COPY ./deploy/scripts/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./deploy/scripts/nginx.conf /etc/nginx/nginx.conf
COPY ./deploy/scripts/supervisor.conf /etc/supervisor.conf

# Copy src
COPY ./src /var/www/src

WORKDIR /var/www

# storage folder permissions
RUN chown -R www:www src/storage

### Composer optimize
ARG OPTIMIZE_COMPOSER=false
RUN if \
        [ $OPTIMIZE_COMPOSER = "true" ] ; \
    then \
        php composer.phar dump-autoload -v --optimize --classmap-authoritative; \
    else \
        php composer.phar dump-autoload -v; \
    fi

### Compile assets
COPY ./webpack.mix.js webpack.mix.js
ARG OPTIMIZE_ASSETS=false
RUN if \
        [ $OPTIMIZE_ASSETS = "true" ] ; \
    then \
        node_modules/webpack/bin/webpack.js --hide-modules -p --config=node_modules/laravel-mix/setup/webpack.config.js; \
    else \
        node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js; \
    fi

CMD ["supervisord", "-n", "-c", "/etc/supervisor.conf"]