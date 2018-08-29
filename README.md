# What's this?
This skeleton allows to have a working Laravel application running inside a Docker container completely out of the box, and configurable through environment variables.

## Features
* Run as a [Docker](https://docs.docker.com/) container: one dependency, one tool, Docker.
* [Laravel 5.6](https://laravel.com/docs/5.6) application.
* Xdebug support
* `up.sh` and `local.up.sh` included: get the application running in your local with the simple command `./deploy/up.sh`
* Production-ready: Optimize Composer's autoload, optimize assets compilation or add HTTP Basic Authentication.
* Configure your build by using simple environment variables

## How to install it
* This skeleton is available as a [composer package in packagist.org](https://packagist.org/packages/gbmcarlos/skellington), so you only need to run `composer create-project --remove-vcs --no-install --ignore-platform-reqs gbmcarlos/skellington target-directory 2.3.*` with the name of the folder where you want to create the project
* After that, just `cd` into the project folder and start a new repository with `git init` and add your new remote with `git remote add origin {new_remote}`
* Start working

## Requirements
* Docker
* To install it in the way stated above you will need PHP and Composer. ([Here](https://getcomposer.org/download/)'s how to get composer)

## Use of environment variables
|       ENV VAR        |  Default value | Description |
| -------------------- | -------------- | ----------- |
| HOST_PORT            | 80             | The port Docker will use as the host port in the network bridge. This is the external port, the one your app will be called through (build argument only) |
| COMPOSER_OPTIMIZE    | false          | Optimize Composer's autoload with [Optimization Level 2/A](https://getcomposer.org/doc/articles/autoloader-optimization.md#optimization-level-2-a-authoritative-class-maps) (build argument only) |
| ASSETS_OPTIMIZE      | false          | Optimize assets compilation (build argument only) |
| BASIC_AUTH_ENABLED   | false          | Enable Basic Authentication with Apache (Persisted environment variable) |
| BASIC_AUTH_USER      | admin          | If `BASIC_AUTH_ENABLED` is true, this will be used to run `htpasswd` together with `BASIC_AUTH_PASSWORD` to encrypt with bcrypt (cost 10) (build argument only) |
| BASIC_AUTH_PASSWORD  | password       | If `BASIC_AUTH_ENABLED` is true, this will be used to run `htpasswd` together with `BASIC_AUTH_USER` to encrypt with bcrypt (cost 10) (build argument only) |
| XDEBUG_ENABLED       | false          | Enables and configures Xdebug inside the container (build argument only) |
| XDEBUG_REMOTE_HOST   | 10.254.254.254 | Used as the `xdebug.remote_host` PHP ini configuration value (build argument only) |
| XDEBUG_REMOTE_PORT   | 9000           | Used as the `xdebug.remote_port` PHP ini configuration value (build argument only) |
| XDEBUG_IDE_KEY       | PHPSTORM       | Used as the `xdebug.idekey` PHP ini configuration value (build argument only) |

These environment variables are used only in the `up.sh` and `local.up.sh` scripts as part of the docker `build` and `run` commands. If you are going to build and run the docker image and container by yourself, make sure to pass these values accordingly.

Also, any additional values that you want to make available inside the container at run time as environment variables will have to be added to the `docker run` command manually (see [Docker's documentation](https://docs.docker.com/engine/reference/run/#env-environment-variables) on how to do it), or included in a `.env` file for Laravel (see [Laravel's documentation](https://laravel.com/docs/5.6/configuration#environment-configuration) on dot env files). A default `.env` file is created by this skeleton. 

Example:
`HOST_PORT=8000 BASIC_AUTH_ENABLED=true BASIC_AUTH_USER=user BASIC_AUTH_PASSWORD=password ./deploy/local.up.sh`

## Built-in Stack
* [Debian (:stretch slim)](https://hub.docker.com/_/debian/)
* Apache 2
* [PHP 7.2.8 (:7.2-apache-stretch)](https://hub.docker.com/_/php/)
* Xdebug 2.6
* Laravel 5.6
* jQuery 3.2
* Bootstrap 4.1

## License

This project is licensed under the terms of the [MIT license](https://opensource.org/licenses/MIT).