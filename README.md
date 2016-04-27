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

* Out of the box support for PHP 5.5, Ruby 1.9.3, Node 4.x (LTS) and Node 5.x (stable).
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
