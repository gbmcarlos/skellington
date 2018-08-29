FROM php:7.2-apache-stretch

LABEL maintainer="gbmcarlos@gmail.com"

### System dependencies
#### git and zip are necessary to use composer
#### gnupg2 is necessary to setup node later with curl
RUN     apt-get update \
    &&  apt-get upgrade -y \
    &&  apt-get -yq install \
            autoconf \
            gnupg2 \
            git \
            zip \
    && rm -rf /var/lib/apt/lists/*

### PHP extensions
RUN docker-php-ext-install \
        pdo \
        pdo_mysql

### NodeJS and NPM
RUN     curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    &&  apt-get -y install nodejs

COPY ./package.* /var/www/
RUN npm install

### Composer
COPY ./composer.* /var/www/
RUN php /var/www/composer.phar install -v --working-dir=/var/www --no-autoloader --no-suggest --no-dev

### Apache2 configuration
RUN a2enmod rewrite
COPY deploy/scripts/000-default.conf /etc/apache2/sites-available/000-default.conf
ARG BASIC_AUTH_ENABLED=false
ENV BASIC_AUTH_ENABLED $BASIC_AUTH_ENABLED
ARG BASIC_AUTH_USER
ARG BASIC_AUTH_PASSWORD
RUN if \
        [ $BASIC_AUTH_ENABLED = "true" ] ; \
    then \
        htpasswd -cb -B -C 10 /etc/apache2/.htpasswd $BASIC_AUTH_USER $BASIC_AUTH_PASSWORD; \
    fi

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
#TODO FIGURE the 777 OUT
RUN     chown -R www-data:www-data /var/www/src/storage/ \
    &&  chmod 777 /var/www/src/bootstrap/cache

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


WORKDIR /var/www/src

CMD ["apache2ctl", "-D", "FOREGROUND"]