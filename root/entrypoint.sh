#!/bin/bash

# Fix perms on /var/log/services
find /var/log/services -print0 | xargs -0 -r chown nobody
find /var/log/services -type d -print0 | xargs -0 -r chmod 755
find /var/log/services -type f -print0 | xargs -0 -r chmod 644

# Run confd??
echo '=> Running confd to write configuration templates'
confd $CONFD_OPTS

# Handle DevTools key
echo '=> Handle DevTools Private Key'
/devtools-key.sh

# Setup NVM
echo "=> Setting node version to: $NODE_VERSION"
bash --login -c "$HOME/.nvm/nvm.sh && nvm alias default $NODE_VERSION"

echo # blank line for readability

# Run the CMD
bash --login -c "$*"
