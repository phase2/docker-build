FROM centos:7

# Install base packages.
RUN yum -y install epel-release centos-release-scl yum-plugin-ovl deltarpm && \
    yum -y update && \
    yum -y install sudo ssh curl less vim-minimal dnsutils openssl && \
    yum clean all

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms

# Download confd.
ENV CONFD_VERSION 0.11.0
RUN curl -L "https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64" > /usr/bin/confd && \
    chmod +x /usr/bin/confd
ENV CONFD_OPTS '--backend=env --onetime'

RUN yum -y install \
      https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    yum -y update && \
    yum clean all

# Add the IUS repository. This is needed for git2.
RUN curl -L "https://centos7.iuscommunity.org/ius-release.rpm" > /usr/local/ius-release.rpm && \
    rpm -Uvh /usr/local/ius-release.rpm

RUN yum -y install \
    # Install PHP
    php71 \
    php71-php-devel \
    php71-php-gd \
    php71-php-xml \
    php71-php-pdo \
    php71-php-mysql \
    php71-php-mysqlnd \
    php71-php-mbstring \
    php71-php-fpm \
    php71-php-opcache \
    php71-php-pecl-memcache \
    php71-php-pecl-xdebug \
    php71-php-posix \
    php71-php-mcrypt \
    php71-php-pecl-yaml \
    php71-php-pecl-zip \
    # Install Ruby
    ruby193 \
    ruby193-rubygems \
    ruby193-ruby-devel \
    # Install Miscellaneous Tools
    bzip2 \
    gcc-c++ \
    git2u-all \
    httpd-tools \
    jq \
    make \
    mariadb \
    nmap-ncat \
    patch \
    postgresql \
    pv \
    rsync \
    sendmail \
    unzip \
    # Necessary for drush
    which \
    # Necessary library for phantomjs per https://github.com/ariya/phantomjs/issues/10904
    fontconfig \
    && yum clean all

# Ensure ruby193 binaries are in path
ENV PATH /root/.composer/vendor/bin:/opt/rh/ruby193/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Ensure PHP binaries are in path
RUN ln -sfv /opt/remi/php71/root/usr/bin/* /usr/bin/ && \
    ln -sfv /opt/remi/php71/root/usr/sbin/* /usr/sbin/

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

# Configure Git
# https://git-scm.com/docs/git-config#git-config-corepreloadIndex
RUN git config --global core.preloadindex true

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

# Run the s6-based init.
ENTRYPOINT ["/init"]

# Set up a standard volume for logs.
VOLUME ["/var/log/services"]

CMD [ "/versions.sh" ]
