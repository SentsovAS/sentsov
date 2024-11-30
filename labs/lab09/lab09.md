**Лабораторная работа - Конфигурация безопасности коммутатора**

![alt text](image-14.png)

**Часть 1. Настройка основного сетевого устройства**

**Шаг 1. Создайте сеть.**

a.	Создайте сеть согласно топологии.

b.	Инициализация устройств

**Шаг 2. Настройте маршрутизатор R1.**

a.	Загрузите следующий конфигурационный скрипт на R1.
Откройте окно конфигурации

enable

configure terminal

hostname R1

no ip domain-lookup

ip dhcp excluded-address 192.168.10.1 192.168.10.9

ip dhcp excluded-address 192.168.10.201 192.168.10.202

!

ip dhcp pool STUDENTS

 network 192.168.10.0 255.255.255.0

 default-router 192.168.10.1

 domain-name CCNA2.Lab-11.6.1

!

interface Loopback0

 ip address 10.10.1.1 255.255.255.0

!

interface GigabitEthernet0/0/1

 description Link to S1

 ip dhcp relay information trusted

 ip address 192.168.10.1 255.255.255.0

 no shutdown

!

line con 0

 logging synchronous  
 
 #запрещает вывод консольных сообщений, которые прерывают ввод команд в консольном режиме

 exec-timeout 0 0   
 
 #устанавливает в ноль время тайм-аута консольного сеанса EXEC

b.	Проверьте текущую конфигурацию на R1, используя следующую команду:

R1# show ip interface brief

c.	Убедитесь, что IP-адресация и интерфейсы находятся в состоянии up / up (при необходимости устраните неполадки).

![alt text](image-15.png)


**Шаг 3. Настройка и проверка основных параметров коммутатора**

a.	Настройте имя хоста для коммутаторов S1 и S2.
Откройте окно конфигурации

b.	Запретите нежелательный поиск в DNS.

c.	Настройте описания интерфейса для портов, которые используются в S1 и S2.

d.	Установите для шлюза по умолчанию для VLAN управления значение 192.168.10.1 на обоих коммутаторах.


Настройка коммутатора S1

Enable

Conf t

Hostname s1

no ip domain-lookup

int f0/1

description #trunk link

exit

int f0/5

description #link to R1

exit

int f0/6

description #link to PC-A

exit

ip default-gateway 192.168.10.1 

copy run start

!


Настройка коммутатора S2

Enable

Conf t

Hostname S2

no ip domain-lookup

int f0/1

description #trunk link

exit

int f0/18

description #link to PC-A

exit

ip default-gateway 192.168.10.1 

copy run start

**Часть 2. Настройка сетей VLAN на коммутаторах.**

**Шаг 1. Сконфигруриуйте VLAN 10.**

Добавьте VLAN 10 на S1 и S2 и назовите VLAN - Management.

**Шаг 2. Сконфигруриуйте SVI для VLAN 10.**

Настройте IP-адрес в соответствии с таблицей адресации для SVI для VLAN 10 на S1 и S2. Включите интерфейсы SVI и предоставьте описание для интерфейса

**Шаг 3. Настройте VLAN 333 с именем Native на S1 и S2.**

**Шаг 4. Настройте VLAN 999 с именем ParkingLot на S1 и S2.**

Первый коммутатор

Enable 

Conf t

Vlan 10  

Name Management

Vlan 999 

Name Parkinglot

Vlan 333

Name Native

exit

Interface vlan 10

Ip add 192.168.10.201 255.255.255.0

ip default-gateway 192.168.10.1

exit

Interface range F0/2-4, F0/7-24, G0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface range f0/5, f0/6

switchport mode access

switchport access vlan 10

exit

interface f0/1

switchport mode trunk

switchport trunk native vlan 333

switchport trunk allowed vlan 10,333

Do copy run start

!


Второй коммутатор

Enable 

Conf t

Vlan 10  

Name Management

Vlan 999 

Name Parkinglot

Vlan 333

Name Native

exit

Interface vlan 10

Ip add 192.168.10.202 255.255.255.0

ip default-gateway 192.168.10.1

exit

Interface range F0/2-17, F0/19-24, G0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface f0/18

switchport mode access

switchport access vlan 10

exit

interface f0/1

switchport mode trunk

switchport trunk native vlan 333

switchport trunk allowed vlan 10,333

Do copy run start


**Часть 3. Настройки безопасности коммутатора.**

**Шаг 1. Релизация магистральных соединений 802.1Q.**

a.	Настройте все магистральные порты Fa0/1 на обоих коммутаторах для использования VLAN 333 в качестве native VLAN.

b.	Убедитесь, что режим транкинга успешно настроен на всех коммутаторах.
S1# show interface trunk

![alt text](image-16.png)

S2# show interface trunk

![alt text](image-17.png)

c.	Отключить согласование DTP F0/1 на S1 и S2. 

conf t

int f0/1

switchport nonegotiate

d.	Проверьте с помощью команды show interfaces.

do show interfaces f0/1 switchport | include Negotiation

![alt text](image-18.png)

do show interfaces f0/1 switchport | include Negotiation

![alt text](image-19.png)


**Шаг 2. Настройка портов доступа**

a.	На S1 настройте F0/5 и F0/6 в качестве портов доступа и свяжите их с VLAN 10.

interface range f0/5, f0/6

switchport mode access

switchport access vlan 10

b.	На S2 настройте порт доступа Fa0/18 и свяжите его с VLAN 10.

interface f0/18

switchport mode access

switchport access vlan 10

**Шаг 3. Безопасность неиспользуемых портов коммутатора**

a.	На S1 и S2 переместите неиспользуемые порты из VLAN 1 в VLAN 999 и отключите неиспользуемые порты.

!

S1
Interface range F0/2-4, F0/7-24, G0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

!

S2

Interface range F0/2-17, F0/19-24, G0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

b.	Убедитесь, что неиспользуемые порты отключены и связаны с VLAN 999, введя команду  show.

show interfaces status

![alt text](image-20.png)

![alt text](image-21.png)


**Шаг 4. Документирование и реализация функций безопасности порта.**

Интерфейсы F0/6 на S1 и F0/18 на S2 настроены как порты доступа. На этом шаге вы также настроите безопасность портов на этих двух портах доступа.

a.	На S1, введите команду show port-security interface f0/6  для отображения настроек по умолчанию безопасности порта для интерфейса F0/6. Запишите свои ответы ниже.

![alt text](image-22.png)

!

b.	На S1 включите защиту порта на F0 / 6 со следующими настройками:

o	Максимальное количество записей MAC-адресов: 3

o	Режим безопасности: restrict

o	Aging time: 60 мин.

o	Aging type: неактивный

c.	Verify port security on S1 F0/6.
!

Коммутатор S1

conf t

int f0/6

#включить режим безопасности, команда:

switchport portsecurity

#Режим безопасности (Violation Mode): restrict, команда:

switchport port-security violation restrict 

#Максимальное количество записей MAC-адресов: 3, команда:

switchport port-security maximum 3

#Время устаривания 60 минут, команда:

switchport port-security aging time 60

#Тип устаревания неактивный Inactivity, команла:

switchport port-security aging type Inactivity


d.	Включите безопасность порта для F0 / 18 на S2. Настройте каждый активный порт доступа таким образом, чтобы он автоматически добавлял адреса МАС, изученные на этом порту, в текущую конфигурацию.

e.	Настройте следующие параметры безопасности порта на S2 F / 18:

o	Максимальное количество записей MAC-адресов: 2

o	Тип безопасности: Protect

o	Aging time: 60 мин.

f.	Проверка функции безопасности портов на S2 F0/18.

show port-security interface f0/6

![alt text](image-24.png)



Коммутатор S2

conf t

int f0/18

#включить режим безопасности, команда:

switchport portsecurity

#Режим безопасности (Violation Mode): protect, команда:

switchport port-security violation protect 

#Максимальное количество записей MAC-адресов: 2, команда:

switchport port-security maximum 2

#Время устаривания 60 минут, команда:

switchport port-security aging time 60

show port-security interface f0/18


![alt text](image-23.png)


**Шаг 5. Реализовать безопасность DHCP snooping.**

a.	На S2 включите DHCP snooping и настройте DHCP snooping во VLAN 10.

b.	Настройте магистральные порты на S2 как доверенные порты.

c.	Ограничьте ненадежный порт Fa0/18 на S2 пятью DHCP-пакетами в секунду.

conf t

int f0/18

ip dhcp snooping vlan 10

no ip dhcp snooping information option

ip dhcp snooping limit rate 5              #пять DHCP-пакетов в секунду

exit

int f0/1

ip dhcp snooping trust

do copy run start

d.	Проверка DHCP Snooping на S2.

S2# show ip dhcp snooping

![alt text](image-25.png)

e.	В командной строке на PC-B освободите, а затем обновите IP-адрес.

ipconfig /release

ipconfig /renew

![alt text](image-26.png)

f.	Проверьте привязку отслеживания DHCP с помощью команды show ip dhcp snooping binding.

show ip dhcp snooping binding 

![alt text](image-27.png)

**Шаг 6. Реализация PortFast и BPDU Guard**

a.	Настройте PortFast на всех портах доступа, которые используются на обоих коммутаторах.

b.	Включите защиту BPDU на портах доступа VLAN 10 S1 и S2, подключенных к PC-A и PC-B.

c.	Убедитесь, что защита BPDU и PortFast включены на соответствующих портах.

Коммутатор S1

conf t 

int range f0/1, f0/6, f0/5

spanning-tree portfast

exit

int range f0,6

spanning-tree bpduguard enable

show spanning-tree interface f0/6 detail

![alt text](image-28.png)



!

Коммутатор S2

conf t 

int range f0/1, f0/18

spanning-tree portfast

exit

int f0/18

spanning-tree bpduguard enable


**Шаг 7. Проверьте наличие сквозного ⁪подключения.**

Проверьте PING свзяь между всеми устройствами в таблице IP-адресации. В случае сбоя проверки связи может потребоваться отключить брандмауэр на хостах.

![alt text](image-29.png)

![alt text](image-30.png)


**Вопросы для повторения**

1.	С точки зрения безопасности порта на S2, почему нет значения таймера для оставшегося возраста в минутах, когда было сконфигурировано динамическое обучение - sticky?

возможно нет таймера устаревания из за того что switchport port-security violation protect при нарушениях, от неизвестного MAC адреса пакеты отбрасываются, но при этом никаких сообщений об ошибках не генерируется

а причем тут sticky я не понял, мы их нигде не включали, все адреса в нашем примере получаются динамически

2.	Что касается безопасности порта на S2, если вы загружаете скрипт текущей конфигурации на S2, почему порту 18 на PC-B никогда не получит IP-адрес через DHCP?

потому что порту f0/18 присвоен dhcp snooping на определенный vlan, в нашем случаи = 10

3.	Что касается безопасности порта, в чем разница между типом абсолютного устаревания и типом устаревание по неактивности?

при настройке absolute адреса удаляются по истечению указанного времени устаревания, а при inactivity адреса удаляются только если они неактивны в течении указанного времени