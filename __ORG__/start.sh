#!/bin/bash
/usr/sbin/sshd
/usr/local/nginx/sbin/nginx
/usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/usr/local/mysql/var --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=/usr/local/mysql/var/nodejs.err --open-files-limit=65535 --pid-file=/usr/local/mysql/var/nodejs.pid --socket=/tmp/mysql.sock --port=3306
/usr/local/php/sbin/php-fpm