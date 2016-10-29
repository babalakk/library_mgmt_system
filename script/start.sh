#!/bin/bash

set -x
rm -rf /var/lib/mysql/*
mysql_install_db
nginx 
python /flask/server.py &
mysqld_safe
