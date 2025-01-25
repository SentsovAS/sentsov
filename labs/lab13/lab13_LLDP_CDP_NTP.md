![image](https://github.com/user-attachments/assets/fa0a3ad0-433e-41b5-8201-c62a1df1d442)


# Часть 1. Создание сети и настройка основных параметров устройства

# Шаг 1. Создайте сеть согласно топологии.

# Шаг 2. Настройте базовые параметры для маршрутизатора.

a.	Назначьте маршрутизатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Настройка интерфейсов, перечисленных в таблице выше

i.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

# Настройка роутера R1

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

password cisco

Login 

Exit

int g0/0/1

ip add 10.22.0.1 255.255.255.0

no shutdown

exit

int lo1

ip add 172.16.1.1 255.255.255.0

no shutdown

do copy run start

# Шаг 3. Настройте базовые параметры каждого коммутатора.

a.	Присвойте коммутатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер, который предупреждает всех, кто обращается к устройству, видит баннерное сообщение «Только авторизованные пользователи!».  

h.	Отключите неиспользуемые интерфейсы

i.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

# Настройка коммутатора s1

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

password cisco

Login 

Exit

Vlan 1

Name SVI

Vlan 999

Name parkinglot

Vlan 1000

Name Native

exit

Interface vlan 1

Ip add 10.22.0.2 255.255.255.0

no shutdown

exit

int range f0/2-4, f0/6-24, g0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

ip default-gateway 10.22.0.1  (для реального коммутатора команда ip route 10.202.0.1)

do copy run start


# Настройка коммутатора s2

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

password cisco

Login 

Exit

Vlan 1

Name SVI

Vlan 999

Name parkinglot

Vlan 1000

Name Native

exit

Interface vlan 1

Ip add 10.22.0.3 255.255.255.0

no shutdown

exit

int range f0/2-24, g0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

ip default-gateway 10.22.0.1  (для реального коммутатора команда ip route 10.202.0.1)

do copy run start

# Часть 2. Обнаружение сетевых ресурсов с помощью протокола CDP

На устройствах Cisco протокол CDP включен по умолчанию. Воспользуйтесь CDP, чтобы обнаружить порты, к которым подключены кабели.
Откройте окно конфигурации

a.	На R1 используйте соответствующую команду show cdp, чтобы определить, сколько интерфейсов включено CDP, сколько из них включено и сколько отключено.
 
Вопрос:
Сколько интерфейсов участвует в объявлениях CDP? Какие из них активны?
Введите ваш ответ здесь.
 
b. На R1 используйте соответствующую команду show cdp, чтобы определить версию IOS, используемую на S1.

R1 # show cdp entry  S1

-------------------------
Device ID: S1
Entry address(es):
Platform: cisco WS-C2960+24LC-L, Capabilities: Switch IGMP 
Interface: GigabitEthernet0/0/1, Port ID (outgoing port): FastEthernet0/5
Holdtime : 125 sec

Version :
Cisco IOS Software, C2960 Software (C2960-LANBASEK9-M), Version 15.2(4)E8, RELEASE SOFTWARE (fc3) 
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2019 by Cisco Systems, Inc.
Compiled Fri 15-Mar-19 17:28 by prod_rel_team 

advertisement version: 2
VTP Management Domain: ''
Native VLAN: 1
Duplex: full
Вопрос:
Какая версия IOS используется на  S1?

![image](https://github.com/user-attachments/assets/a20e0755-a99a-41d4-a52c-73c7119d53b3)


На S1 используется IOS версии: 2

c.	На S1 используйте соответствующую команду show cdp, чтобы определить, сколько пакетов CDP было выданных.

S1# show cdp traffic

CDP counters : 
        Total packets output: 179, Input: 148 
        Hdr syntax: 0, Chksum error: 0, Encaps failed: 0 
        No memory: 0, Invalid packet: 0, 
        CDP version 1 advertisements output: 0, Input: 0 
        CDP version 2 advertisements output: 179, Input: 148
Вопрос:
Сколько пакетов имеет выход CDP с момента последнего сброса счетчика?

выход CDP с момента последнего сброса счетчика имеет 179 пакетов

d.	Настройте SVI для VLAN 1 на S1 и S2, используя IP-адреса, указанные в таблице адресации выше. Настройте шлюз по умолчанию для каждого коммутатора на основе таблицы адресов

e.	На R1 выполните команду show cdp entry S1 . 

Какие дополнительные сведения доступны теперь?

Добавилась строчка с  ip адресом 10.22.0.2

f.	Отключить CDP глобально на всех устройствах. 

# Заъодим на каждое утройство

no cdp run

# Чтобы отключить CDP для определенного интерфейса, вводим no cdp enable в режиме настройки интерфейса.

# Часть 3. Обнаружение сетевых ресурсов с помощью протокола LLDP

На устройствах Cisco протокол LLDP может быть включен по умолчанию. Воспользуйтесь LLDP, чтобы обнаружить порты, к которым подключены кабели.
Откройте окно конфигурации

a.	Введите соответствующую команду lldp, чтобы включить LLDP на всех устройствах в топологии.

b.	На S1 выполните соответствующую команду lldp, чтобы предоставить подробную информацию о S2. 

S1# show lldp entry S2

Capability codes:
    (R) Router, (B) Bridge, (T) Telephone, (C) DOCSIS Cable Device
    (W) WLAN Access Point, (P) Repeater, (S) Station, (O) Other
------------------------------------------------
Local Intf: Fa0/1  
Chassis id: c025.5cd7.ef00 
Port id: Fa0/1 
Port Description: FastEthernet0/1
System Name: S2

System Description:
Cisco IOS Software, C2960 Software (C2960-LANBASEK9-M), Version 15.2(4)E8, RELEASE SOFTWARE (fc3) 
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2019 by Cisco Systems, Inc.
Compiled Fri 15-Mar-19 17:28 by prod_rel_team 

Time remaining: 109 seconds 
System Capabilities: B
Enabled Capabilities: B
Management Addresses:
    IP: 10.22.0.3 
Auto Negotiation - supported, enabled
Physical media capabilities:
    100base-TX(FD)
    100base-TX(HD)
    10base-T(FD)
    10base-T(HD)
Media Attachment Unit type: 16
Vlan ID: 1


Total entries displayed: 1
Вопрос:
Что такое chassis ID  для коммутатора S2?

В качестве Chassis ID используется MAC-адрес интерфейса управления

# Часть 4. Настройка NTP

В части 4 необходимо настроить маршрутизатор R1 в качестве сервера NTP, а маршрутизатор R2 в качестве клиента NTP маршрутизатора R1. Необходимо выполнить синхронизацию времени для Syslog и отладочных функций. Если время не синхронизировано, сложно определить, какое сетевое событие стало причиной данного сообщения.

# Шаг 1. Выведите на экран текущее время.

Введите команду show clock для отображения текущего времени на R1. Запишите отображаемые сведения о текущем времени в следующей таблице


show clock

![image](https://github.com/user-attachments/assets/778962b6-768f-482e-9be4-9d8df3e0c161)


# Шаг 2. Установите время.

С помощью команды clock set установите время на маршрутизаторе R1. Введенное время должно быть в формате UTC. 

clock set 19:31:00 25 jan 2025

# Шаг 3. Настройте главный сервер NTP.

Настройте R1 в качестве хозяина NTP с уровнем слоя 4.

conf t 

ntp server 10.22.0.1

ntp master 4

do copy run start

# Шаг 4. Настройте клиент NTP.

ntp server 10.22.0.1

show ntp associations

show clock detail

# Для каких интерфейсов в пределах сети не следует использовать протоколы обнаружения сетевых ресурсов? Поясните ответ.

Интерфейсы с высокой степенью уязвимости (открытые в интернет)

Интерфейсы на устройствах, которые не поддерживают данные протоколы

Помимо уязвимости, данные протоколы могут повысить нагрузку на оборудование и еще нежелательно использовать их в сетях с динамическо изменяющейся конфигурацией (например в сетях с частым передвижением устройств)





