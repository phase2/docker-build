FROM phase2/servicebase7

RUN yum -y update

RUN yum install -y nodejs npm
RUN yum install -y git
RUN yum install -y php php-curl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer

# Install Drush
RUN composer global require drush/drush:dev-master
RUN composer global update

# Install Grunt, etc.
RUN npm install -g grunt-cli
RUN npm install --save-dev grunt
RUN npm install --save-dev git+https://github.com/phase2/grunt-drupal-tasks.git

# Put composer installed packages in the PATH
ENV PATH /root/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Run something to keep the container up so we can nsenter it
CMD while true; do sleep 360000; done
