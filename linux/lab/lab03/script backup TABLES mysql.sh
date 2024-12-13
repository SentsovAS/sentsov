#!/bin/bash

mkdir -p /backup/mysql/   # создаем директорию куда будут сохранятся бакапы

DB_USER="username"
DB_NAME="test"                 # имя бд       
DATE=$(date +%Y-%m-%d)         # текущая дата
MYSQL="/usr/bin/mysql"         # путь к утилите\команде
MYSQLDUMP="/usr/bin/mysqldump" #путь к утилите\команде
TABLES=$($mysql -u $DB_USER $DB_NAME -e "show tables;" | grep -v Tables) # получаем список таблиц в базе данных

for TABLE in $TABLES;
do
$mysqldump -u $DB_USER $DB_NAME $TABLE | /usr/bin/gzip -c > /backup/mysql/$DATE/$TABLE.sql.gz
done