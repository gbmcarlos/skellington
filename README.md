# What's this?
This skeleton allows to have a working Laravel or Lumen application running inside a Docker container completely out of the box, and configurable through environment variables.

## Features
* Run as a [Docker](https://docs.docker.com/) container: one dependency, one tool, Docker.
* [Lumen 7](https://lumen.laravel.com/docs/7.x) application.
* Xdebug support
* Run it with Make
    * `make` or `make run` will run the project as web service
    * `make command ARGS={your command}` will execute your arguments as a Artisan command
* Configure the run-time environment with environment variables
    * Debug in your local with `XDEBUG_` env vars

## How to install it
* `curl -o- -s -L https://gbmcarlos.com/skellington.sh | bash`
* Start working

# Setup

## Requirements
* Docker

## Environment variables

Every project reads its environment variables from the file `src/.env`, which is not tracked in the repository by git. A list of the required environment variables is kept in the file `src/.env.example`.

## Crossbow

This project makes use of gbmcarlos/toolkit as a library, which is installed as a git submodule.

## Development

### Web service

When working on the web service, use `make` or `make logs`. This script will:

* build the Docker image
* run the Docker container, mounting volumes for the source and vendor folders. This will:
  * make the dependencies \(installed only inside the container\) visible to your IDE.
  * make all changes on those folders reflect instantly inside the container
* spin up the web server
* tail the output of the container

### Background process

When working on a background process, use `make command ARGS={your command}`. This script will do the same as `make logs`, but instead of spinning up the web server, it will run the specified Artisan command with the given options. For example

```bash
./local/run.sh my-command
```

## Configuration environment variables

These environment variables are used to configure how the project is built and ran, and they are given a default value optimized for production in the Dockerfile. Makefile gives them a default value optimized for local development which overrides the one in the Dockerfile.

| ENV VAR | Default value \(production \| local\) | Description |
| :--- | :--- | :--- |
| APP\_PORT | 80 | The port Docker will use as the host port in the network bridge. This is the external port, the one you will use to call your app. |
| APP\_DEBUG | `true` | Use to toggle the application debug configuration |
| APP\_NAME | Name of the project's root folder | Used to name the docker image and docker container. |
| APP\_RELEASE | Current commit hash \(`HEAD`\) / `latest` | Used at build time to persist the environment variable into the image. |
| BASIC\_AUTH\_ENABLED | `true` / `false` | Enables Basic Authentication with Nginx. If enabled, it will use `htpasswd` with `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD` to encrypt with bcrypt \(cost 10\). |
| BASIC\_AUTH\_USERNAME | admin | Username for the Basic Auth |
| BASIC\_AUTH\_PASSWORD | `APP_NAME`\_password | Password for the Basic Auth |
| XDEBUG\_ENABLED | `false` / `true` | Enables Xdebug inside the container. |
| XDEBUG\_REMOTE\_HOST | host.docker.internal | Used as the `xdebug.remote_host` PHP ini configuration value. |
| XDEBUG\_REMOTE\_PORT | 10000 | Used as the `xdebug.remote_port` PHP ini configuration value. |
| XDEBUG\_IDE\_KEY | `APP_NAME`\_PHPSTORM | Used as the `xdebug.idekey` PHP ini configuration value. |

```bash
APP_PORT=8000 BASIC_AUTH_ENABLED=true BASIC_AUTH_USERNAME=user BASIC_AUTH_PASSWORD=secure_password XDEBUG_ENABLED=true make
```

## Running commands

To run a arbitrary command inside your web service container, you can do so with:

```bash
docker exec -it {container-name} bash -c "{command}"
```

Or you can execute an interactive terminal in the container with:

```bash
docker exec -it {container-name} bash
```

## Installing a new package

When installing a new package let Composer choose the exact version by running `composer require {package}` inside the container \(see the "Running commands" section\). Then extract the `composer.json` and `composer.lock` from inside the container \(see the "Updating dependencies" section\).

## Updating dependencies

To update the dependencies, run `composer update` inside the web service container \(see the "Running commands" section\). Then extract the `composer.lock` file with:

```bash
docker cp {container-name}:/var/task/composer.lock .
```

### Updating NPM dependencies \(Laravel only\)

To update the NPM dependencies, run `npm update` inside the web service container \(see the "Running commands" section\). Then extract the `package-lock.json` file with:

```bash
docker cp {container-name}:/var/www/package-lock.json .
```

Then you can copy the result into your `.env` as the value of the variable `APP_KEY`

## Xdebug support

Even though the project runs inside a Docker container, it still provides support for debugging with Xdebug. By telling Xdebug the remote location of your IDE and configuring this one to listen to a certain port, they can communicate with one another.

Use the `XDEBUG_` environment variables to configure your project's debugging. The default values on the local start-up scripts are optimized for PhpStorm on Mac.

### Xdebug for PhpStorm on Mac

Check [this documentation](https://gist.github.com/gbmcarlos/77614789be8a6ecc1dc3aec4b49c07bc) to configure your IDE. Use the `XDEBUG_` and `APP_NAME` environment variables and the path mappings:

* "src": `/var/task/src`
* "vendor": `/opt/vendor`

## Technology Stack

* [Nginx](http://nginx.org/)
* [PHP 7.4.1](https://php.net/)
* [Xdebug](https://xdebug.org/)
* [Lumen 7](https://lumen.laravel.com/docs/7.x)

## License
This project is licensed under the terms of the [MIT license](https://opensource.org/licenses/MIT).