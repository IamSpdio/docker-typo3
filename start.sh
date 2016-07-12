#!/bin/bash

MYSQL_ROOT_PASSWORD=${DB_ENV_MYSQL_ROOT_PASSWORD:-raphael}
MYSQL_DB_USER=${MYSQL_DB_USER:-raphael}
MYSQL_DB_DB=${MYSQL_DB_DB:-raphael}

sed -i "s/'password' => '123456',/'password' => '${MYSQL_ROOT_PASSWORD}',/g" /var/www/html/typo3conf/LocalConfiguration.php
sed -i "s/'username' => 'root',/'username' => '${MYSQL_DB_USER}',/g" /var/www/html/typo3conf/LocalConfiguration.php
sed -i "s/'database' => 'typo3',/'database' => '${MYSQL_DB_DB}',/g" /var/www/html/typo3conf/LocalConfiguration.php

exec /usr/bin/supervisord
