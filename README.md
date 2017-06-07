# Outrigger Build

> The Outrigger Build image provides a command-line toolkit for PHP & Node development with Drupal support.

## Supported tags and respective `Dockerfile` links

-	[`php55` (*php55/Dockerfile*)](https://github.com/phase2/docker-build/blob/master/php55/Dockerfile) [![](https://images.microbadger.com/badges/image/outrigger/build:php55.svg)](https://microbadger.com/images/outrigger/build:php55 "Get your own image badge on microbadger.com")
-	[`php56` (*php56/Dockerfile*)](https://github.com/phase2/docker-build/blob/master/php56/Dockerfile) [![](https://images.microbadger.com/badges/image/outrigger/build:php56.svg)](https://microbadger.com/images/outrigger/build:php56 "Get your own image badge on microbadger.com")
-	[`php70` (*php70/Dockerfile*)](https://github.com/phase2/docker-build/blob/master/php70/Dockerfile) [![](https://images.microbadger.com/badges/image/outrigger/build:php70.svg)](https://microbadger.com/images/outrigger/build:php70 "Get your own image badge on microbadger.com")
-	[`php71` (*php71/Dockerfile*)](https://github.com/phase2/docker-build/blob/master/php71/Dockerfile) [![](https://images.microbadger.com/badges/image/outrigger/build:php71.svg)](https://microbadger.com/images/outrigger/build:php71 "Get your own image badge on microbadger.com")

This image provides the many development tools necessary to build applications
the Outrigger way, bundled with a wide array of tools useful for development and
troubleshooting via the command-line interface. While it is possible to directly
connect to the web containers, this is the preferred way to perform "server work".

For more documentation on how Outrigger images are constructed and how to work
with them, please [see the documentation](http://docs.outrigger.sh).

## Features

* Out of the box support for PHP (version based on tag), Ruby and multiple Node LTS versions (based on environment var, see below)
* Global availability of Composer, Drush, NPM, Bower, Grunt, Gulp, and Yeoman.

For more details of specific packages, libraries, and utilities, please see the
[Dockerfile](https://github.com/phase2/docker-build/blob/master/php71/Dockerfile).

### Drush (Drupal Shell) Integration

There is global configuration for Drush at `/etc/drush/drushrc.php`.

Default configuration in this file provides the following:

* Unlimited memory for PHP operations run via Drush.
* Unlimited execution time for PHP operations run via Drush.
* Drush commands will be looked up in `/etc/drush/commands`.
* Drush aliases will be looked up in `/etc/drush`.

### Additional Commands

* **Registry Rebuild**: `drush rr` is included by default.

### BASH History Persistence

If you would like your bash history preserved, provide a volume mount to a persistent
data location at /root/bash and initialization scripts will ensure your .bash\_history
file is written there. For example `/data/PROJECT/ENV/bash:/root/bash`

## Environment Variables

Outrigger images use Environment Variables and [confd](https://github.com/kelseyhightower/confd) to templatize a number 
of Docker environment configurations. These templates are processed on startup with environment variables passed in 
via the docker run command-line or via your `docker-compose.yml` manifest file. Here are the "tunable" configurations 
offered by this image.

* `NODE_VERSION`: [`4`|`6`|`8`] Defaults to 4. Selects the major version of Node
  to make available to all tools via nvm. The latest minor release as of the image build will be used.
* `PHP_XDEBUG`: [`"true"`|`"false"`] Specify whether the PHP Xdebug extension should be enabled.

## Maintainers

[![Phase2 Logo](https://s3.amazonaws.com/phase2.public/logos/phase2-logo.png)](https://www.phase2technology.com)
