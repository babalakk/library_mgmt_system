#!/bin/bash

set -x
rm -rf /var/lib/mysql/*
mysql_install_db
nginx 
python /lms/server.py &
mysqld_safe
