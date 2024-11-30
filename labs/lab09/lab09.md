**Лабораторная работа - Конфигурация безопасности коммутатора**

![image](https://github.com/user-attachments/assets/6af0b98f-5530-4668-8359-44bb7b63a74b)


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

![image](https://github.com/user-attachments/assets/01709ab3-4c4a-4caf-8f5a-5927d745d808)



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

![image](https://github.com/user-attachments/assets/c0fb82b8-2256-4a13-b178-d7047d7101f3)


S2# show interface trunk

![image](https://github.com/user-attachments/assets/74f7c450-aaca-4416-91aa-aac6eac567c1)


c.	Отключить согласование DTP F0/1 на S1 и S2. 

conf t

int f0/1

switchport nonegotiate

d.	Проверьте с помощью команды show interfaces.

do show interfaces f0/1 switchport | include Negotiation

![image](https://github.com/user-attachments/assets/e2fcff3c-a097-46e7-aa03-d08ff9feba1b)


do show interfaces f0/1 switchport | include Negotiation

![image](https://github.com/user-attachments/assets/7122e208-491d-4a56-a7ac-2c4d629a0bb9)



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

![image](https://github.com/user-attachments/assets/a370d1a8-16bb-4c48-82bd-3e1764e1c033)


![image](https://github.com/user-attachments/assets/1383bcef-de35-44c5-bba2-51d309e0a6f7)



**Шаг 4. Документирование и реализация функций безопасности порта.**

Интерфейсы F0/6 на S1 и F0/18 на S2 настроены как порты доступа. На этом шаге вы также настроите безопасность портов на этих двух портах доступа.

a.	На S1, введите команду show port-security interface f0/6  для отображения настроек по умолчанию безопасности порта для интерфейса F0/6. Запишите свои ответы ниже.

![image](https://github.com/user-attachments/assets/dcf0e563-0f79-4fae-afd2-a5c450ccb1b6)


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

![image](https://github.com/user-attachments/assets/ff028a4a-6cb1-4075-aaf8-2adde6b8ff17)




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


![image](https://github.com/user-attachments/assets/31c511d0-300f-47ef-9e26-f5e0dacf477d)



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

![image](https://github.com/user-attachments/assets/0df8824a-df31-4300-b8bf-ecb420e19bf8)


e.	В командной строке на PC-B освободите, а затем обновите IP-адрес.

ipconfig /release

ipconfig /renew

![image](https://github.com/user-attachments/assets/b27478a5-942a-4823-819e-d7a35c1e0db1)


f.	Проверьте привязку отслеживания DHCP с помощью команды show ip dhcp snooping binding.

show ip dhcp snooping binding 

![image](https://github.com/user-attachments/assets/cd6690d1-a6cf-47fe-a639-d9f107fb24d0)


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

![image](https://github.com/user-attachments/assets/08850932-7311-4015-85ed-16e5d71e972b)




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

![image](https://github.com/user-attachments/assets/e9ad14ac-534f-4439-b9b7-e6bbda2e861f)


![image](https://github.com/user-attachments/assets/30974342-dc47-438b-8f32-12c13f27187c)



**Вопросы для повторения**

1.	С точки зрения безопасности порта на S2, почему нет значения таймера для оставшегося возраста в минутах, когда было сконфигурировано динамическое обучение - sticky?

возможно нет таймера устаревания из за того что switchport port-security violation protect при нарушениях, от неизвестного MAC адреса пакеты отбрасываются, но при этом никаких сообщений об ошибках не генерируется

а причем тут sticky я не понял, мы их нигде не включали, все адреса в нашем примере получаются динамически

2.	Что касается безопасности порта на S2, если вы загружаете скрипт текущей конфигурации на S2, почему порту 18 на PC-B никогда не получит IP-адрес через DHCP?

потому что порту f0/18 присвоен dhcp snooping на определенный vlan, в нашем случаи = 10

3.	Что касается безопасности порта, в чем разница между типом абсолютного устаревания и типом устаревание по неактивности?

при настройке absolute адреса удаляются по истечению указанного времени устаревания, а при inactivity адреса удаляются только если они неактивны в течении указанного времени
