## What's this?
This skeleton allows to have a working Laravel application running inside a Docker container completely out of the box, and configurable through environment variables.

### Features
* Run as a [Docker](https://docs.docker.com/) container: only one dependency, Docker. It can be deployed in any decent modern server. It can be deployed in a matter of minutes.
* [Laravel](https://laravel.com/docs/5.6) application.
* `up.sh` and `local.up.sh` included: get the application running in your local with the simple command `./deploy/local.up.sh`
* Production-ready: it will optimize Composer's autoload in production

### How to install it
* This skeleton is available as a [composer package in packagist.org](https://packagist.org/packages/gbmcarlos/skellington), so you only need to run `composer create-project --remove-vcs gbmcarlos/skellington --no-install [folder-name]` with the name of the folder where you want to create the project
* After that, just `cd` into the project folder and start a new repository with `git init` and add your new remote with `git remote add origin {new_remote}`
* Start working

### Requirements
* Docker
* To install it in the way stated above you will need PHP and Composer. ([Here](https://getcomposer.org/download/)'s how to get composer)

### Environment variables available

|       ENV VAR      | Default value | Description |
| ------------------ | ------------- | ----------- |
| HOST_PORT          | 80            | The port Docker will use as the host port in the network bridge. This is the external port, the one your app will be called through |
| CONTAINER_PORT     | 80            | The port that Apache will listen to from inside the container. If `APACHE_USER` is a non-root user, this can not be under 1024, [here](https://www.w3.org/Daemon/User/Installation/PrivilegedPorts.html)'s why  |
| COMPOSER_OPTIMIZE  | false         | Optimize Composer's autoload with [Optimization Level 2/A](https://getcomposer.org/doc/articles/autoloader-optimization.md#optimization-level-2-a-authoritative-class-maps) |

Example:
`HOST_PORT=8000 ./deploy/local.up.sh`

### Built-in Stack
* [Debian (:stretch slim)](https://hub.docker.com/_/debian/)
* Apache 2
* [PHP 7.2.8 (:7.2-apache-stretch)](https://hub.docker.com/_/php/)
* Laravel 5.6
* jQuery 3.2
* Bootstrap 4.1

## Once installed

### Development
TL;DR: run `./deploy/local.up.sh` once and start coding.

When developing in a local environment, just run `./deploy/local.up.sh`.
This will build the image and run the container normally, but mounting volumes for the source and vendors folders.

By mounting volumes on those folders, it makes the dependencies (installed only inside the container) available outside the container (so available to your IDE).
Also it makes all changes on those folders reflect instantly inside the container, so there is no need to re-deploy.

Running `./deploy/local.up.sh` will also automatically tail the output of the container.

### Running commands
Since the application runs inside the container, all commands have to be executed there. To do so, run `docker exec -it ecp /bin/sh -c "{command}"`.
For example, to run a Artisan command, run `docker exec -it ecp /bin/sh -c "php artisan config:cache"`

## Watch assets
To watch the assets (see the compiled changes instantly reflect after every change) run `docker exec ecp /var/www/compile-assets.sh watch`

### Extract lock files (updating dependencies)
Composer lock: docker cp ecp:/var/www/composer.lock $PWD/../../composer.lock
NPM lock: docker cp ecp:/var/www/package-lock.json $PWD/../../package-lock.json