1.	Подготовка к установке

Устанавливаем ubuntu 22 на 2 хоста\виртуальные машины

После установки:

Sudo su

Apt update

Apt upgrade

apt install mysql-server-8.0

!


2.	Настраиваем конфиг для мастера

Cd /etc/mysql/mysql.conf.d/

Nano mysqld.cnf


В секции [mysqld]

Меняем адрес локальный на любой из нашей сети

bind-address = 127.0.0.1 на bind-address = 0.0.0.0


server-id = 1

log-bin = mysql-bin

binlog_format = row

gtid-mode=ON

enforce-gtid-consistency

log-replica-updates

ctrl+o

ctrl+x

service mysql restart

Заходим в mysql сервер

mysql

создаем пользователя для реплики

CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2020';

Выдаем ему права

GRANT REPLICATION SLAVE ON *.* TO repl@'%';


3.	Настраиваем конфиг реплики

Cd /etc/mysql/mysql.conf.d/

Nano mysqld.cnf


В секции [mysqld]

Меняем адрес локальный на любой из нашей сети

bind-address = 127.0.0.1 на bind-address = 0.0.0.0

server-id = 2

log-bin = mysql-bin

relay-log = relay-log-server

read-only = ON

gtid-mode=ON

enforce-gtid-consistency

log-replica-updates

ctrl+o

ctrl+x

service mysql restart

myqsl

#на всякий случай останавливаем реплику (не для нашего примера, так как сервер новый, но все же, хороший тон)

STOP REPLICA    

CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.106.119', SOURCE_USER='repl', SOURCE_PASSWORD='oTUSlave#2020', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1;

START REPLICA;  

Проверяем что нет ошибок подключения и авторизации

Show replica status\G

   


На мастере создаем базу данных test

Mysql

Create database test;

Переключаемся на реплику

Смотрим

Mysql

Show databases;

 
База test на реплике появилась

