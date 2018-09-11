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

# Copy php-fpm's config
COPY ./deploy/scripts/php-fpm.conf /usr/local/etc/php-fpm.conf
# And delete the default one
RUN rm -rf /usr/local/etc/php-fpm.d

# Copy nginx's config
COPY ./deploy/scripts/nginx.conf /etc/nginx/nginx.conf

# Copy supervisor's config
COPY ./deploy/scripts/supervisor.conf /etc/supervisor.conf

COPY ./src /var/www/src

CMD ["supervisord", "-n", "-c", "/etc/supervisor.conf"]