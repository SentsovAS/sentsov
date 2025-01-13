# Полезная информация по iptables:


# -L — посмотреть список правил (можно указать цепочку, иначе выводятся все);

sudo iptables -nvL --line-numbers

# удалить правило с порядковым номером, например - 4

iptables -D IMPUT 4  (порядковый номер правила мы можем увидеть предыдущей командой iptables -nvL --line-numbers)

# -P — установить политику по умолчанию для заданной цепочки;

sudo iptables -P INPUT DROP

# или

sudo iptables -P INPUT ACCEPT

# Просмотреть цепочки для другой таблицы

iptables -t nat -L

iptables -t nat -nvL --line-numbers  

# Разрешить только те пакеты, которые мы запросили

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Редирект порта

iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

# Сохранение правил временно\сохранение и восстановление значений

iptables-save > ./iptables.rules

iptables-restore < ./iptables.rules

# Работа с NAT

iptables -t nat -A PREROUTING -p tcp --dport 9022 -j DNAT --to 192.168.1.1:22

# Сохранение правил

apt install iptables-persistent netfilter-persistent

netfilter-persistent save

netfilter-persistent start



============================= ДЗ ============================

# 1. Настроить разрешения в iptables, открыть TCP-порты 80, 22 и 443.

iptables -A INPUT -p tcp --dport=22 -j ACCEPT

iptables -A INPUT -p tcp --dport=80 -j ACCEPT

iptables -A INPUT -p tcp --dport=443 -j ACCEPT


# 2. Запретить все внешние подключения, кроме указанных выше.

iptables -A INPUT -p tcp -j DROP

# важно чтобы данное правило не было выше тех что мы указывали в первой часте задания, иначе оно будет перекрывать их и доступа по портам 22, 80 и 443 мы не получим

# 3. Сделать автовосстановление правил фильтрации после перезагрузки ОС

# Можно сохранить наши правила в отдельный файл iptables.sentsov

iptables-save > ./iptables.sentsov

# После перезагрузки все правила сбросятся, но их можно быстро восстановить из файла iptables.sentsov

iptables-restore < ./iptables.sentsov или iptables-save < ./iptables.sentsov

# Можно написать скрипт или установить утилиту чтобы сохранить правила на постоянную основу

# Устанавливаем утилиту 

apt install iptables-persistent netfilter-persistent

netfilter-persistent save

netfilter-persistent start

# iptables -nvL --line-numbers

![image](https://github.com/user-attachments/assets/d7b075f9-bed1-4c96-803c-ed0261a46263)



