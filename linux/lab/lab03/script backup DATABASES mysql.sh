#!/bin/bash


date=`date +%Y-%m-%d`
MYSQL="/usr/bin/mysql"
MYSQLDUMP="/usr/bin/mysqldump"
DATABASES="$mysql -e "show databases;" | grep -v information_schema | grep -v Database"

for dbname in $DATABASES; 
do
$mysqldump $dbname | /usr/bin/gzip -c > /backup/mysql/$date-$dbname.sql.gz;
done