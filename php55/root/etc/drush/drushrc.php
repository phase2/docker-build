<?php

// Let drush use unlimited memory.
ini_set('memory_limit', -1);

// Allow Drush to run forever.
ini_set('max_execution_time', -1);

// Look for alias files.
$options['alias-path'] = '/etc/drush';

// Look for command files for auto-include.
$options['include'] = '/etc/drush/commands';
