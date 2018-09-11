FROM php:7.2-fpm-alpine

LABEL maintainer="gbmcarlos@gmail.com"

## vim and bash are utilities, so that we can work inside the container while debugging
RUN     apk update \
    &&  apk add \
            bash \
            vim \
            supervisor \
            nginx

RUN adduser -D -g 'www' www

### Composer install
COPY ./composer.* /var/www/
RUN php /var/www/composer.phar install -v --working-dir=/var/www --no-autoloader --no-suggest --no-dev

# Copy php-fpm, nginx and supervirost config files
COPY ./deploy/scripts/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./deploy/scripts/nginx.conf /etc/nginx/nginx.conf
COPY ./deploy/scripts/supervisor.conf /etc/supervisor.conf

# Copy src
COPY ./src /var/www/src
# storage folder permissions
RUN chown -R www-data:www-data /var/www/src/storage

### Composer optimize
ARG OPTIMIZE_COMPOSER=false
RUN if \
        [ $OPTIMIZE_COMPOSER = "true" ] ; \
    then \
        php /var/www/composer.phar dump-autoload -v --working-dir=/var/www --optimize --classmap-authoritative; \
    else \
        php /var/www/composer.phar dump-autoload -v --working-dir=/var/www; \
    fi

CMD ["supervisord", "-n", "-c", "/etc/supervisor.conf"]