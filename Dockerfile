FROM php:7.2-apache-stretch

LABEL maintainer="gbmcarlos@gmail.com"

### System dependencies
RUN     apt-get update \
    &&  apt-get upgrade -y \
    &&  apt-get -yq install \
            libpng-dev \
            autoconf \
            gnupg2 \
            git \
            zip \
            libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/*

### PHP extensions
RUN docker-php-ext-install \
        pdo \
        pdo_mysql \
        pcntl
RUN pecl install imagick && \
    echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

### Apache2 configuration
COPY deploy/scripts/main.conf /etc/apache2/sites-available/main.conf
RUN a2enmod rewrite macro && a2dissite 000-default && a2ensite main && sed -i 's/^Listen 80/#Listen80/' /etc/apache2/ports.conf

### NodeJS and NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -y install nodejs

COPY ./package.* /var/www/
RUN npm install

### Composer
COPY ./composer.* /var/www/
RUN php /var/www/composer.phar install -v --working-dir=/var/www --no-autoloader --no-suggest --no-dev

### Source code
COPY ./src /var/www/src

WORKDIR /var/www

### Composer optimizie
ARG COMPOSER_OPTIMIZE=false
RUN if \
        [ $COMPOSER_OPTIMIZE = "true" ] ; \
    then \
        php composer.phar dump-autoload -v --working-dir=/var/www --optimize --classmap-authoritative; \
    else \
        php composer.phar dump-autoload -v --working-dir=/var/www; \
    fi

### Storage folders permissions
RUN chown -R www-data:www-data /var/www/src/storage/
#TODO FIGURE THIS OUT
RUN chmod 777 /var/www/src/bootstrap/cache

### Compile assets
COPY ./webpack.mix.js /var/www/webpack.mix.js
ARG ASSETS_OPTIMIZE=false
RUN if \
        [ $ASSETS_OPTIMIZE = "true" ] ; \
    then \
        node_modules/webpack/bin/webpack.js --hide-modules -p --config=node_modules/laravel-mix/setup/webpack.config.js; \
    else \
        node_modules/webpack/bin/webpack.js --hide-modules --config=node_modules/laravel-mix/setup/webpack.config.js; \
    fi

### Port env var
ARG CONTAINER_PORT=80
ENV PORT $CONTAINER_PORT

WORKDIR /var/www/src

CMD ["apache2ctl", "-D", "FOREGROUND"]