![logo](https://www.phase2technology.com/wp-content/uploads/2015/06/logo-retina.png)

## Description

This image provides the many development tools necessary to build applications
the Phase2 way, bundled with a wide array of tools useful for development and
troubleshooting via the command-line interface. While it is possible to directly
connect via our "web" containers, this is the preferred way to perform "server work".

Contains everything you need to work with Drupal, including use of tools such as
[Grunt-Drupal-Tasks](https://github.com/phase2/grunt-drupal-tasks) and
[Pattern Lab Starter](https://github.com/phase2/pattern-lab-starter/).

## Available Packages & Tools

* Out of the box support for PHP (version based on tag), Ruby 1.9.3 and Node versions
4.x (LTS), 5.x (stable) and 6.x (LTS) based on environment toggle (see below).
* Global availability of Composer, NPM, Bower, Grunt, and Yeoman.

For more details of specific packages, libraries, and utilities, please see the
[Dockerfile](https://bitbucket.org/phase2tech/p2docker/src/master/p2docker-devtools-build/Dockerfile).

## Drush (Drupal Shell) Configuration

There is global configuration for Drush at `/etc/drush/drushrc.php`.

Default configuration in this file provides the following:

* Unlimited memory for PHP operations run via Drush.
* Unlimited execution time for PHP operations run via Drush.
* Drush commands will be looked up in `/etc/drush/commands`.
* Drush aliases will be looked up in `/etc/drush`.

### Additional Commands

* **Registry Rebuild**: `drush rr` is included by default.

## Environment Variables
When you start the devtools-build image, you can adjust the configuration of the
build instance by passing one or more environment variables on the docker run
command-line or via your docker-compose manifest file.

Additional environment variables for commonly customized settings will be considered.

### NODE_VERSION

Specify the version of Node.js to use.

* **Default**: `4`
* **Node 5.x**: `5`
* **Node 6.x**: `6`

### PHP_XDEBUG

Specify if the xdebug extension should be enabled

* **Default**: "false"
* **Enable xdebug**: "true"

## Other Conveniences

### Bash history persistence between invocations

If you would like your bash history preserved, provide a volume mount to a persistent
data location at /root/bash and initialization scripts will ensure your .bash\_history
file is written there. For example `/data/PROJECT/bash:/root/bash`
