FROM outrigger/keel:1.0

# Add Labels for differences from outrigger/keel.
# @see http://label-schema.org/rc1/
# CentOS adds a name label but it is misleading in our instance.
LABEL \
  name="Outrigger Build (PHP)" \
  org.label-schema.name="Outrigger Build (PHP)" \
  org.label-schema.description="A CentOS-based image that facilitates interconnected build and operational tasks for PHP." \
  org.label-schema.vcs-url="https://github.com/phase2/docker-build" \
  org.label-schema.docker.cmd="docker run -it --rm outrigger/build:php70 bash" \
  org.label-schema.docker.cmd.help="docker run -it --rm outrigger/build:php70"

# Install base packages.
RUN yum -y install centos-release-scl \
    && yum -y update

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms

RUN yum -y install \
      https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum -y update

# Install language runtimes and additional tools.
RUN yum -y install \
    # Install PHP
    php70 \
    php70-php-devel \
    php70-php-gd \
    php70-php-xml \
    php70-php-pdo \
    php70-php-mysql \
    php70-php-mysqlnd \
    php70-php-mbstring \
    php70-php-fpm \
    php70-php-opcache \
    php70-php-pecl-memcache \
    php70-php-pecl-xdebug \
    php70-php-posix \
    php70-php-mcrypt \
    # Install Ruby
    ruby193 \
    ruby193-rubygems \
    ruby193-ruby-devel \
    # Install Miscellaneous Tools
    gcc-c++ \
    httpd-tools \
    mariadb \
    nmap-ncat \
    postgresql \
    # Necessary library for phantomjs per https://github.com/ariya/phantomjs/issues/10904
    fontconfig \
    && yum clean all \
    && rm -rf /var/cache/yum

# Ensure ruby193 binaries are in path
ENV PATH /root/.composer/vendor/bin:/opt/rh/ruby193/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Ensure PHP binaries are in path
RUN ln -sfv /opt/remi/php70/root/usr/bin/* /usr/bin/ && \
    ln -sfv /opt/remi/php70/root/usr/sbin/* /usr/sbin/

# Install PHPRedis extension
ENV PHPREDIS_VERSION 3.1.2
RUN curl -L -o /tmp/phpredis.tar.gz "https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz" && \
    tar -xzf /tmp/phpredis.tar.gz -C /tmp && \
    rm /tmp/phpredis.tar.gz && \
    cd "/tmp/phpredis-$PHPREDIS_VERSION" && \
    phpize && \
    ./configure && \
    make && \
    make install

# Enable other ruby193 SCL config
ENV LD_LIBRARY_PATH /opt/rh/ruby193/root/usr/lib64
ENV PKG_CONFIG_PATH /opt/rh/ruby193/root/usr/lib64/pkgconfig

# Ensure $HOME is set
ENV HOME /root

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer
# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

# Add global composer dependencies.
# Drush for drupal development.
# prestissimo for parallelized composer download operations.
RUN composer global require drush/drush:8.x hirak/prestissimo:^0.3 && \
  composer clear-cache

# Install nvm, supported node versions, and default cli modules.
ENV NVM_DIR $HOME/.nvm
ENV NODE_VERSION 4
RUN (curl https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash) && \
  chmod +x $HOME/.nvm/nvm.sh

# Node 4.x (LTS)
RUN source $NVM_DIR/nvm.sh && \
  nvm install 4 && \
  npm install -g bower grunt-cli gulp-cli && \
  npm cache clean
# Node 6.x (stable)
RUN source $NVM_DIR/nvm.sh && \
  nvm install 6 && \
  npm install -g bower grunt-cli gulp-cli && \
  npm cache clean
# Node 8.x (stable)
RUN source $NVM_DIR/nvm.sh && \
  nvm install 8 && \
  npm install -g bower grunt-cli gulp-cli && \
  # npm v5 recommends not clearing caches because of improved consistency.
  # This is not an argument that applies to Docker image layer size.
  npm cache clean --force
# Set the default version which can be overridden by ENV.
RUN source $NVM_DIR/nvm.sh && nvm alias default $NODE_VERSION && nvm cache clear

# Configure npm for container life.
ENV NPM_CONFIG_UNSAFE_PERM true
# Configure bower for container life.
ENV BOWER_ALLOW_ROOT true

COPY root /

# Install Drush commands
RUN drush pm-download -yv registry_rebuild-7.x --destination=/etc/drush/commands

CMD [ "/versions.sh" ]
