**Лабораторная работа - Внедрение маршрутизации между виртуальными локальными сетями**

!

![image](https://github.com/user-attachments/assets/3c411b43-8f0c-4039-8976-fdc9dbc12da6)


!

![image](https://github.com/user-attachments/assets/db74da92-1638-4462-829c-6d336b7d92d8)


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

![image](https://github.com/user-attachments/assets/58060346-0c16-4af9-9df3-621ece95c91e)


!

![image](https://github.com/user-attachments/assets/60595e13-43eb-4112-9378-c73d4ba1c1ae)


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

![image](https://github.com/user-attachments/assets/ad1eeb50-8c59-4421-8b20-c4b67cf2e8cf)


!



Второй коммутатор


interface f0/1

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 10,20,30,1000

show interfaces trunk

do copy run start

do show interfaces trunk

![image](https://github.com/user-attachments/assets/feb6bfa8-6cba-45ec-a2ad-5665b40515dd)




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

![image](https://github.com/user-attachments/assets/7215c802-e647-4136-8abb-d2ca56b87a7b)


!

![image](https://github.com/user-attachments/assets/22180d82-1621-4869-8732-fa98be6d5f5b)


!

**b.	Отправьте эхо-запрос с PC-A на PC-B.**

!

![image](https://github.com/user-attachments/assets/e4b9a16e-2328-4650-b292-eb88fb542237)


!

**c.	Отправьте команду ping с компьютера PC-A на коммутатор S2.**

!

![image](https://github.com/user-attachments/assets/8a306e93-7cd0-45e9-b0d3-360039428e50)





**Шаг 2. Пройдите следующий тест с PC-B**

!

**В окне командной строки на PC-B выполните команду tracert на адрес PC-A.**

!

![image](https://github.com/user-attachments/assets/960e62cc-b096-41e2-a958-4b933566a511)


**Какие промежуточные IP-адреса отображаются в результатах?**

1 роутер
2 компьютер pc-a






