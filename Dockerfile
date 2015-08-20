FROM phase2/servicebase

RUN yum -y update

RUN yum install -y nodejs npm
RUN yum install -y git patch make diff tar unzip gzip

# Install PHP 5.5 SCL
RUN yum -y install scl-utils && \
    yum -y localinstall https://www.softwarecollections.org/en/scls/rhscl/php55/epel-6-x86_64/download/rhscl-php55-epel-6-x86_64.noarch.rpm && \
    yum -y localinstall https://www.softwarecollections.org/en/scls/remi/php55more/epel-6-x86_64/download/remi-php55more-epel-6-x86_64.noarch.rpm

RUN yum -y install php55-php-fpm php55-php-cli php55-php-gd php55-php-mcrypt php55-php-mbstring php55-php-pdo php55-php-mysql php55-php-pecl-memcache php55-php-opcache php55-php-pecl-redis php55-php-tidy php55-php-xml php55-php-soap php55-php-bcmath php55-php-imap php55-php-pgsql php55-php-sqlite php55-php-pear php55-php-devel @"Development Tools"

# Ensure php55 binaries are in path
ENV PATH /root/.composer/vendor/bin:/opt/rh/php55/root/usr/bin:/opt/rh/php55/root/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer

# Install Drush
RUN composer global require drush/drush:dev-master
RUN composer global update

# Update npm
RUN npm install -g npm

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

ADD root /
