#!/bin/bash


date=`date +%Y-%m-%d`
MYSQL="/usr/bin/mysql"
MYSQLDUMP="/usr/bin/mysqldump"


for dbname in `mysql -e'show databases;' | grep -v information_schema | grep -v Database`;
do
$mysqldump $dbname | /usr/bin/gzip -c > /backup/mysql/$date-$dbname.sql.gz;
done