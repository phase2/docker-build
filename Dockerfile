FROM phase2/servicebase

RUN add-apt-repository -y ppa:chris-lea/node.js

RUN apt-get -y update

RUN apt-get install -y nodejs
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y php5 php5-curl

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
RUN sed -i '1i export PATH="/root/.composer/vendor/bin:$PATH"' $HOME/.bashrc

# Run something to keep the container up so we can nsenter it
CMD while true; do sleep 360000; done
