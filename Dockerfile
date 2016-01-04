FROM phase2/servicebase

RUN yum -y install \
      https://www.softwarecollections.org/en/scls/rhscl/php55/epel-7-x86_64/download/rhscl-php55-epel-7-x86_64.noarch.rpm \
      https://www.softwarecollections.org/en/scls/remi/php55more/epel-7-x86_64/download/remi-php55more-epel-7-x86_64.noarch.rpm \
      https://www.softwarecollections.org/en/scls/rhscl/ruby193/epel-7-x86_64/download/rhscl-ruby193-epel-7-x86_64.noarch.rpm \
      https://www.softwarecollections.org/en/scls/rhscl/v8314/epel-7-x86_64/download/rhscl-v8314-epel-7-x86_64.noarch.rpm && \
    yum -y update

RUN yum -y install \
      bzip2 \
      gcc-c++ \
      git \
      make \
      mariadb \
      https://rpm.nodesource.com/pub_0.12/el/7/x86_64/nodejs-0.12.7-1nodesource.el7.centos.x86_64.rpm \
      patch \
      php55 \
      php55-php-bcmath \
      php55-php-cli \
      php55-php-devel \
      php55-php-fpm \
      php55-php-gd \
      php55-php-mbstring \
      php55-php-mysql \
      php55-php-opcache \
      php55-php-pdo \
      php55-php-pear \
      php55-php-pgsql \
      php55-php-pecl-memcache \
      php55-php-soap \
      php55-php-xml \
      postgresql \
      ruby193 \
      ruby193-rubygems \
      ruby193-ruby-devel \
      sendmail \
      unzip \
      # Necessary for drush
      which \
      # Necessary library for phantomjs per https://github.com/ariya/phantomjs/issues/10904
      fontconfig

# Ensure php55 and ruby193 binaries are in path
ENV PATH /root/.composer/vendor/bin:/opt/rh/php55/root/usr/bin:/opt/rh/php55/root/usr/sbin:/opt/rh/ruby193/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Enable other ruby193 SCL config
ENV LD_LIBRARY_PATH /opt/rh/ruby193/root/usr/lib64
ENV PKG_CONFIG_PATH /opt/rh/ruby193/root/usr/lib64/pkgconfig

# Ensure $HOME is set
ENV HOME /root

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer

# Install Drush
RUN composer global require drush/drush:dev-master
RUN composer global update

# Update npm
RUN npm install -g npm@^2

# Install Bower, Grunt (CLI), and Yeoman
RUN npm install -g bower grunt-cli yo

ADD root /

# Install Drush commands
RUN drush pm-download -yv registry_rebuild-7.x --destination=/etc/drush/commands

# PHP Tuning
ENV PHP_MEMORY_LIMIT        256m
ENV PHP_OPCACHE_MEMORY      192
ENV MAX_EXECUTION_TIME      30

# Init Configuration
## Suppress init system logging.
ENV S6_LOGGING=1
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=0

# Suppress printing the exit code.
RUN sed -i '/  if { s6-echo -- "${1} exited ${?}" }/d' /etc/s6/init/init-stage2

CMD /devtools_versions.sh
