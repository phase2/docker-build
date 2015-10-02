#!/bin/sh

docker run -it phase2/devtools-build sh -c " \
    echo '' && \
    echo 'Node.js version:' && \
    node --version && \
    echo '' && \
    echo 'npm version:' && \
    npm --version && \
    echo '' && \
    echo 'Bower version:' && \
    bower --version && \
    echo '' && \
    echo 'Grunt version:' && \
    grunt --version && \
    echo '' && \
    echo 'Yeoman version:' && \
    yo --version && \
    echo '' && \
    echo 'Ruby version:' && \
    ruby --version && \
    echo '' && \
    echo 'Bundler version:' && \
    bundle --version && \
    echo '' && \
    echo 'PHP version:' && \
    php --version && \
    echo '' && \
    echo 'Composer version:' && \
    composer --version && \
    echo '' && \
    echo 'Drush version:' && \
    drush --version"
