# Настроить сеть на Linux. Статический IP, DHCP, роутер в кач-ве DNS, Google NS в кач-ве DNS

# 1. Назначить IP адрес для интерфейса с помощью команды ip

# Можно поменять адрес в ручную, не знаю насколько это правильно, но учитель нас такому не обучал, он рекомендовал редактировать конфиг файл в папке /etc/netplan/ 

ifconfig -a

ifconfig enp0s3 192.168.1.200/24

![image](https://github.com/user-attachments/assets/0c11520e-8d86-45ef-9a7f-ed977df2e618)


# Способ которому нас обучил учитель

sudo su

# Переходи в каталог с конфигурационным файлом сетевых настроек

cd /etc/netplan/

ll

![image](https://github.com/user-attachments/assets/a22c53e5-846b-4312-a20d-790f1177edaf)


nano 50-cloud-init.yaml

![image](https://github.com/user-attachments/assets/05b58239-ede6-4580-85e1-8dbd0ebefbb3)


# Видим  что настройки сети получены по DHCP

# Проверяем какой адрес ipv4 мы получили

ip -4 a

![image](https://github.com/user-attachments/assets/d9f97cba-916e-41d5-b347-9c7a3a2cadfc)


192.168.1.103 c /24 маской (255.255.255.0)

# Еще есть виртуальный интерфейс loopback 127.0.0.1 локальный адрес хоста - нашей линукс машины, не обращаем на него внимания.

# 2. Назначить адрес dns сервера

гугл 8.8.8.8

яндекс 77.88.8.8

# 3. Добавить маршрут по умолчанию

192.168.1.1

# 4. Насписать файл конфигурации сети с настроенными ранее параметрами

![image](https://github.com/user-attachments/assets/311a7fbb-6d64-4d25-b1cb-59f2b0632da9)


![image](https://github.com/user-attachments/assets/94d78d97-a7a3-491a-b17d-b1e97b13969e)


