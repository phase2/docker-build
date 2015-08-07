FROM phase2/servicebase

RUN yum -y update

RUN yum install -y nodejs npm
RUN yum install -y git patch diff tar unzip gzip
RUN yum install -y php php-curl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer

# Install Drush
RUN composer global require drush/drush:dev-master
RUN composer global update

# Install Grunt, etc.
RUN npm install -g grunt-cli
RUN npm install --save-dev grunt
RUN npm install --save-dev git+https://github.com/phase2/grunt-drupal-tasks.git

# Run something to keep the container up so we can nsenter it.
# Also create the Drush cache dir on the /data volume.
CMD mkdir /data/.drush; while true; do sleep 1; done

# Make sure that Composer and Drush items make it into the /data volume and not the CoW filesystem.
# Also put composer executables into $PATH.
ENV HOME /root/
ENV CACHE_PREFIX /data/.drush
ENV PATH /root/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ADD root /
