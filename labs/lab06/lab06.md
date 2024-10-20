**Лабораторная работа - Внедрение маршрутизации между виртуальными локальными сетями**

!

![alt text](image.png)

!

![alt text](image-1.png)

!

**Часть 1. Создание сети и настройка основных параметров устройства**

!

**Шаг 1. Создайте сеть согласно топологии.**

!

**Шаг 2. Настройте базовые параметры для маршрутизатора.**

!

Enable

Conf t

Hostname R1

no ip domain-lookup

Line console 0

Password cisco 

Login

exit

Service password-encryption

Enable secret class

Banner motd =warning=

Line vty 0 4

Login local

transport input telnet

password cisco

Exit

Clock set 19:31:00 19 oct 2024

Copy run start

!

**Шаг 3. Настройте базовые параметры каждого коммутатора.**

!

Первый коммутатор

Enable

Conf t

Hostname S1

no ip domain-lookup

Line console 0

Password cisco 

Login

exit

Service password-encryption

Enable secret class

Banner motd =warning=

Line vty 0 4

Login

password cisco

Exit

exit

Clock set 19:46:00 19 oct 2024

Copy run start




!
Второй коммутатор


Enable

Conf t

Hostname S2

no ip domain-lookup

Line console 0

Password cisco 

Login

exit

Service password-encryption

Enable secret class

Banner motd =warning=

Line vty 0 4

Login

password cisco

Exit

Exit

Clock set 19:46:00 19 oct 2024

Copy run start



!
**Шаг 4. Настройте узлы ПК.**

!

![alt text](image-2.png)

!

![alt text](image-3.png)

!

**Часть 2. Создание сетей VLAN и назначение портов коммутатора**

!

**Шаг 1. Создайте сети VLAN на коммутаторах.**

!

**Шаг 2. Назначьте сети VLAN соответствующим интерфейсам коммутатора.**

!


Первый коммутатор

Enable 

Conf t

Vlan 10

Name Control

Vlan 20

Name Sales

Vlan 30

Name Operations

Vlan 999

Name Parking_Lot

Vlan 1000

Name Native

exit

Interface vlan 10

Ip add 192.168.10.11 255.255.255.0

exit

Interface range f0/2-4, f0/7-24, g0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface f0/6

switchport mode access

switchport access vlan 20

exit

ip default-gateway 192.168.10.1

Do copy run start



!


Второй коммутатор

Enable 

Conf t

Vlan 10

Name Control

Vlan 20

Name Sales

Vlan 30

Name Operations

Vlan 999

Name Parking_Lot

Vlan 1000

Name Native

exit

Interface vlan 10

Ip add 192.168.10.12 255.255.255.0

exit

Interface range f0/2-17, f0/19-24, g0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface f0/18

switchport mode access

switchport access vlan 30

ip default-gateway 192.168.10.1

Do copy run start


!

**Часть 3. Конфигурация магистрального канала стандарта 802.1Q между коммутаторами**

!

**Шаг 1. Вручную настройте магистральный интерфейс F0/1 на коммутаторах S1 и S2.**

!

**Шаг 2. Вручную настройте магистральный интерфейс F0/5 на коммутаторе S1.**

!

Первый коммутатор

interface range f0/1, f0/5

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 10,20,30,1000

show interfaces trunk

do copy run start

do show interfaces trunk
!

![alt text](image-4.png)

!



Второй коммутатор


interface f0/1

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 10,20,30,1000

show interfaces trunk

do copy run start

do show interfaces trunk

![alt text](image-5.png)



!

**Что произойдет, если G0/0/1 на R1 будет отключен?**

Свзяи с роутером нет

!

**Часть 4. Настройка маршрутизации между сетями VLAN**

!

Enable

Conf t

Hostname R1

no ip domain-lookup

Line console 0

Password cisco 

Login

exit

Service password-encryption

Enable secret class

Banner motd =warning=

Line vty 0 4

Login local

password cisco

Exit

Clock set 19:31:00 19 oct 2024

Conf t

Interface g0/0/1.10

Description for vlan 10

Enc dot1Q 10

Ip add 192.168.10.1 255.255.255.0

No shutdown

Exit

Interface g0/0/1.20

Description for vlan 20

Enc dot1Q 20

Ip add 192.168.20.1 255.255.255.0

No shutdown

Exit

Interface g0/0/1.30

Description for vlan 30

Enc dot1Q 30

Ip add 192.168.30.1 255.255.255.0

No shutdown

Exit

Interface g0/0/1.1000

Description for vlan native

Enc dot1Q 1000

No shutdown

Exit

Interface g0/0/1

No shutdown

Do Copy run start

!

**Часть 5. Проверьте, работает ли маршрутизация между VLAN**

!

**Шаг 1. Выполните следующие тесты с PC-A. Все должно быть успешно.**

!
**a.	Отправьте эхо-запрос с PC-A на шлюз по умолчанию.**

![alt text](image-8.png)

!

![alt text](image-9.png)

!

**b.	Отправьте эхо-запрос с PC-A на PC-B.**

!

![alt text](image-10.png)

!

**c.	Отправьте команду ping с компьютера PC-A на коммутатор S2.**

!

![alt text](image-12.png)




**Шаг 2. Пройдите следующий тест с PC-B**

!

**В окне командной строки на PC-B выполните команду tracert на адрес PC-A.**

!

![alt text](image-11.png)

**Какие промежуточные IP-адреса отображаются в результатах?**

1 роутер
2 компьютер pc-a






