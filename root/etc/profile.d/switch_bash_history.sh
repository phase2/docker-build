#!/bin/bash

# This script is intended to pair with a docker-compose volume line
# like /data/project_dir/bash:/root/bash to result in persistent
# project restricted bash history preservation between build container
# invocations

TRIGGER_DIR=~/bash

if [ -e $TRIGGER_DIR ]; then
  if [ -e ~/.bash_history ]; then
    rm -f ~/.bash_history
  fi
  ln -s $TRIGGER_DIR/.bash_history ~/.bash_history
fi