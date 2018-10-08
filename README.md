# What's this?
This skeleton allows to have a working Laravel application running inside a Docker container completely out of the box, and configurable through environment variables.

## Features
* Run as a [Docker](https://docs.docker.com/) container: one dependency, one tool, Docker.
* [Laravel 5.7](https://laravel.com/docs/5.7) application.
* Xdebug support
* Multiple start-up scripts provided
    * `up.sh`: (supposed to run on the host, located in `deploy/`) to deploy the application with configuration values optimized for production using environment variables
    * `local.up.sh`: (supposed to run on the host, located in `deploy/`) to deploy the application in your development environment, tailing logs and mounting volumes for your source code, to work comfortably
    * `configure.sh`: (supposed to run inside the Docker container, located in `/var/www`) it configures the run-time environment according to the `OPTIMIZE_`, `XDEBUG_` and `BASIC_AUTH_` environment variables
    * `entrypoint.sh`: (supposed to run inside the Docker container, located in `/var/www`) executes `configure.sh` and starts the web service (start nginx and php-fpm through supervisord) (this is the default entry point of the Docker container)
* Configure the run-time environment with environment variables
    * Optimize multiple aspects of your application for production with `OPTIMIZE_` env vars
    * Set Basic Authentication with `BASIC_AUTH_` env vars
    * Debug in your local with `XDEBUG_` env vars

## How to install it
* This skeleton is available as a [composer package in packagist.org](https://packagist.org/packages/gbmcarlos/skellington), so you only need to run `composer create-project --remove-vcs --no-install --ignore-platform-reqs gbmcarlos/skellington target-directory 3.1.*` with the name of the folder where you want to create the project
* After that, just `cd` into the project folder and start a new repository with `git init` and add your new remote with `git remote add origin {new_remote}`
* Start working

## Requirements
* Docker
* To install it in the way stated above you will need PHP and Composer. ([Here](https://getcomposer.org/download/)'s how to get composer)

## Environment variables available
These environment variables are given a default value in the `up.sh` and `local.up.sh` (host) scripts, and also in the `configure.sh` and `entrypoint.sh` (container) scripts. The default value in any of the host scripts will override the default value in the container scripts.

|       ENV VAR        |                 Default value                 | Description |
| -------------------- | --------------------------------------------- | ----------- |
| PROJECT_NAME         | Name of the project's root folder (`localhost` in the container scripts)  | Used to name the docker image and docker container from the `up.sh` files, and as the name server in nginx. |
| HOST_PORT            | 80                                                                        | The port Docker will use as the host port in the network bridge. This is the external port, the one your app will be called through. |
| OPTIMIZE_PHP         | `true` (`false` in `local.up.sh`)                                         | Sets PHP's configuration values about error reporting and display [the right way](https://www.phptherightway.com/#error_reporting) and enables [OPCache](https://secure.php.net/book.opcache). |
| OPTIMIZE_COMPOSER    | `true` (`false` in `local.up.sh`)                                         | Optimizes Composer's autoload with [Optimization Level 2/A](https://getcomposer.org/doc/articles/autoloader-optimization.md#optimization-level-2-a-authoritative-class-maps). |
| OPTIMIZE_ASSETS      | `true` (`false` in `local.up.sh`)                                         | Optimizes assets compilation. |
| BASIC_AUTH_ENABLED   | `true` (`false` in `local.up.sh`)                                         | Enables Basic Authentication with Nginx. |
| BASIC_AUTH_USERNAME  | admin                                                                     | If `BASIC_AUTH_ENABLED` is `true`, it will be used to run `htpasswd` together with `BASIC_AUTH_PASSWORD` to encrypt with bcrypt (cost 10). |
| BASIC_AUTH_PASSWORD  | `PROJECT_NAME`_password                                                   | If `BASIC_AUTH_ENABLED` is `true`, it will be used to run `htpasswd` together with `BASIC_AUTH_USERNAME` to encrypt with bcrypt (cost 10). |
| XDEBUG_ENABLED       | `false` (`true` in `local.up.sh`)                                         | Enables Xdebug inside the container. |
| XDEBUG_REMOTE_HOST   | 10.254.254.254                                                            | Used as the `xdebug.remote_host` PHP ini configuration value. |
| XDEBUG_REMOTE_PORT   | 9000                                                                      | Used as the `xdebug.remote_port` PHP ini configuration value. |
| XDEBUG_IDE_KEY       | `PROJECT_NAME`_PHPSTORM                                                   | Used as the `xdebug.idekey` PHP ini configuration value. |

Example:
```
HOST_PORT=8000 BASIC_AUTH_ENABLED=true BASIC_AUTH_USERNAME=user BASIC_AUTH_PASSWORD=secure_password XDEBUG_ENABLED=true ./deploy/local.up.sh
```  
You can also run the container yourself and override the container's command to run a different process:
```
docker run --name background-process --rm -v $PWD/src:/var/www/src --rm -w /var/www -e XDEBUG_ENABLED=true -e PROJECT_NAME=skellington -e OPTIMIZE_ASSETS=false skellington:latest /bin/sh -c "/var/www/configure.sh && php -i"
```

## Built-in Stack
* [Alpine Linux 3.8 (:3.8)](https://hub.docker.com/_/alpine/)
* [Nginx 1.14.1](http://nginx.org/)
* [PHP 7.2.8 (:7.2-fpm-alpine3.8)](https://hub.docker.com/_/php/)
* [Xdebug 2.6.1](https://xdebug.org/)
* [Laravel 5.7](https://laravel.com/docs/5.7/)
* [Node.js 8.11.4](https://nodejs.org/en/docs/)

## License
This project is licensed under the terms of the [MIT license](https://opensource.org/licenses/MIT).