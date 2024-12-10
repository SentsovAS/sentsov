#!/bin/bash


destination="/backup/mysql"
userDB="repl"
passwordDB="oTUSlave#2020"
date=`date +%Y-%m-%d`
MYSQL="/usr/bin/mysql"
MYSQLDUMP="/usr/bin/mysqldump"
DBList="$($MYSQL -u $userDB -p$passwordDB -Bse 'show databases')"
for dbname in $DBlist;
do
mysqldump --databases --no-tablespaces --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers -u$userDB -p$passwordDB $dbname | gzip > $destination/$date/$dbname.sql.gz
done;
