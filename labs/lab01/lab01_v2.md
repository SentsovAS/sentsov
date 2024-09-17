**Лабораторная работа. Базовая настройка коммутатора**
![image](https://github.com/user-attachments/assets/74eca304-35c7-45bd-bc9a-377c5b91a169)





**Часть 1. Проверка конфигурации коммутатора по умолчанию**

Конфигурация коммутатора по умолчанию
Building configuration...

Current configuration : 1080 bytes


version 15.0

no service timestamps log datetime msec

no service timestamps debug datetime msec

no service password-encryption


hostname Switch


spanning-tree mode pvst

spanning-tree extend system-id


interface FastEthernet0/1


interface FastEthernet0/2


interface FastEthernet0/3


interface FastEthernet0/4


interface FastEthernet0/5


interface FastEthernet0/6


interface FastEthernet0/7


interface FastEthernet0/8


interface FastEthernet0/9


interface FastEthernet0/10


interface FastEthernet0/11


interface FastEthernet0/12


interface FastEthernet0/13


interface FastEthernet0/14


interface FastEthernet0/15


interface FastEthernet0/16


interface FastEthernet0/17


interface FastEthernet0/18


interface FastEthernet0/19


interface FastEthernet0/20


interface FastEthernet0/21


interface FastEthernet0/22


interface FastEthernet0/23


interface FastEthernet0/24


interface GigabitEthernet0/1


interface GigabitEthernet0/2


interface Vlan1

no ip address

shutdown

line con 0


line vty 0 4

login

line vty 5 15

login


end

**Почему нужно использовать консольное подключение для первоначальной настройки коммутатора? Почему нельзя подключиться к коммутатору через Telnet или SSH?**

Потому что изначально коммутатор не настроен и у него нет ip адреса на интерфейсах, подключиться по telnet/ssh не получится.


**Сколько интерфейсов FastEthernet имеется на коммутаторе 2960?**

24

**Сколько интерфейсов Gigabit Ethernet имеется на коммутаторе 
2960?**

2

**Каков диапазон значений, отображаемых в vty-линиях?**

0 4, 5 15c.

**Изучите файл загрузочной конфигурации (startup configuration), который содержится в энергонезависимом ОЗУ (NVRAM).**

система выдала ошибку 
**startup-config is not present**

**Почему появляется это сообщение?**

Потому что:  я ничего не менял в конфигурации, а если бы и менял, то все изменения находились в временной памяти\текущем конфиге, не копировал\сохранял текущий конфиг в загрузочный (copy running-config startup-config)
**Изучите характеристики SVI для VLAN 1**

ip адрес не назначен

mac адрес 000a.4147.8225

данный интерфейс по умолчанию выключен и включается после настройки (присвоению ip адреса)

**Изучите IP-свойства интерфейса SVI сети VLAN 1.   Какие выходные данные вы видите?**

MAC адрес интерфейса

Ip адрес с маской

MTU 1500 максимальный размер одного пакета, настройки скорости и дуплекса 

Количество переданных пакетов и другие параметры, которые мне неизвестны 


**Какие выходные данные вы видите после подключения кабеля ethernet:**

Hardware is CPU Interface, address is 000a.4147.8225 (bia 000a.4147.8225)

Internet address is 192.168.1.2/24

MTU 1500 bytes, BW 100000 Kbit, DLY 1000000 usec,
reliability 255/255, txload 1/255, rxload 1/255

Encapsulation ARPA, loopback not set

ARP type: ARPA, ARP Timeout 04:00:00

Last input 21:40:21, output never, output hang never

Last clearing of "show interface" counters never

Input queue: 0/75/0/0 (size/max/drops/flushes); 
Total output drops: 0

Queueing strategy: fifo

Output queue: 0/40 (size/max)

5 minute input rate 0 bits/sec, 0 packets/sec

5 minute output rate 0 bits/sec, 0 packets/sec

1682 packets input, 530955 bytes, 0 no buffer

Received 0 broadcasts (0 IP multicast)

0 runts, 0 giants, 0 throttles

0 input errors, 0 CRC, 0 frame, 0 overrun, 0 ignored

563859 packets output, 0 bytes, 0 underruns

0 output errors, 23 interface resets

0 output buffer failures, 0 output buffers swapped out


 **Под управлением какой версии ОС Cisco IOS работает коммутатор?**

Cisco IOS Software, C2960 Software (C2960-LANBASEK9-M), Version 15.0(2)SE4, RELEASE SOFTWARE (fc1)

**Как называется файл образа системы?**

Затрудняюсь ответить, может быть SPA

**) Изучите свойства по умолчанию интерфейса FastEthernet, который используется компьютером PC-A.**
**Интерфейс включен или выключен?**

Включен (возможно потому что я уже подключил кабель ethernet)

**Что нужно сделать, чтобы включить интерфейс?**

Набрать команду no shutdown

**Какой MAC-адрес у интерфейса?**

0001.6395.e006

**Какие настройки скорости и дуплекса заданы в интерфейсе?**

BW 100000 Kbit, DLY 1000 usec,
reliability 255/255, txload 1/255, rxload 1/255

**Выполните одну из следующих команд, чтобы изучить содержимое флеш-каталога. Switch# show flash**

Directory of flash:/

1 -rw- 4670455 <no date> 2960-lanbasek9-mz.150-2.SE4.bin

2 -rw- 1255 <no date> config.text

64016384 bytes total (59344674 bytes free)

**Какое имя присвоено образу Cisco IOS?**

2960-lanbasek9-mz.150-2.SE4.bin




**Часть 2. Создание сети и настройка основных параметров устройства**

**•	Настройте базовые параметры коммутатора.**

enable

conf t

no ip domain-lookup

hostname S1

service password-encryption

enable secret As131313

banner motd #
Unauthorized access is strictly prohibited. #

line console 0

password As131313

login

line vty 0 4

password As131313

login

transport input telnet

copy running-config startup-config

interface vlan1

ip address 192.168.1.2 255.255.255.0

no shutdown

**Для чего нужна команда login**

Чтобы разрешить вход под указанным паролем



•	**Настройте IP-адрес для ПК.**

![image](https://github.com/user-attachments/assets/ca88a51e-33f7-4b34-a391-2fc8db5b4ded)


**Часть 3. Проверка сетевых подключений**

![image](https://github.com/user-attachments/assets/afa3c491-598a-468f-87b5-b624aedaf81e)




**•	Отобразите конфигурацию устройства.**

version 15.0

no service timestamps log datetime msec

no service timestamps debug datetime msec

service password-encryption

hostname S1

enable secret 5 $1$mERr$.TzPe.s4irmwpSb5UHmGW0

no ip domain-lookup

spanning-tree mode pvst

spanning-tree extend system-id

interface FastEthernet0/1

interface FastEthernet0/2

interface FastEthernet0/3

interface FastEthernet0/4

interface FastEthernet0/5

interface FastEthernet0/6

interface FastEthernet0/7

interface FastEthernet0/8

interface FastEthernet0/9

interface FastEthernet0/10

interface FastEthernet0/11

interface FastEthernet0/12

interface FastEthernet0/13

interface FastEthernet0/14

interface FastEthernet0/15

interface FastEthernet0/16

interface FastEthernet0/17

interface FastEthernet0/18

interface FastEthernet0/19

interface FastEthernet0/20

interface FastEthernet0/21

interface FastEthernet0/22

interface FastEthernet0/23

interface FastEthernet0/24

interface GigabitEthernet0/1

interface GigabitEthernet0/2

interface Vlan1

ip address 192.168.1.2 255.255.255.0

banner motd ^C

Unauthorized access is strictly prohibited. ^C

line con 0

password 7 08005F1F5A48564641

logging synchronous

login

line vty 0 4

password 7 08005F1F5A48564641

login

transport input telnet

line vty 5 15

login

end

•	**Протестируйте сквозное соединение, отправив эхо-запрос.**
![image](https://github.com/user-attachments/assets/6ec98842-e255-41ba-a8ce-f223463ae0e1)


•	**Протестируйте возможности удаленного управления с помощью Telnet**
![image](https://github.com/user-attachments/assets/dac90aba-e9e4-472b-aa4e-be962c555df5)


**Проверьте параметры VLAN 1.**
	
S1# show interface vlan 1 

**Какова полоса пропускания этого интерфейса?**

1500


**Протестируйте сквозное соединение, отправив эхо-запрос
В командной строке компьютера PC-A с помощью утилиты ping проверьте связь сначала с адресом PC-A.**

C:\> ping 192.168.1.10 **

 Cisco Packet Tracer PC Command Line 1.0

C:\>ping 192.168.1.10

Pinging 192.168.1.10 with 32 bytes of data:

Reply from 192.168.1.10: bytes=32 time=6ms TTL=128

Reply from 192.168.1.10: bytes=32 time=20ms TTL=128

Reply from 192.168.1.10: bytes=32 time<1ms TTL=128

Reply from 192.168.1.10: bytes=32 time<1ms TTL=128


Ping statistics for 192.168.1.10:

    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),

Approximate round trip times in milli-seconds:

    Minimum = 0ms, Maximum = 20ms, Average = 6ms

**Из командной строки компьютера PC-A отправьте эхо-запрос на административный адрес интерфейса SVI коммутатора S1**

C:\> ping 192.168.1.2**

C:\>ping 192.168.1.2


Pinging 192.168.1.2 with 32 bytes of data:


Request timed out.

Reply from 192.168.1.2: bytes=32 time<1ms TTL=255

Reply from 192.168.1.2: bytes=32 time<1ms TTL=255

Reply from 192.168.1.2: bytes=32 time<1ms TTL=255


Ping statistics for 192.168.1.2:

    Packets: Sent = 4, Received = 3, Lost = 1 (25% loss),

Approximate round trip times in milli-seconds:

    Minimum = 0ms, Maximum = 0ms, Average = 0ms
     
**Вопросы для повторения**

**Зачем необходимо настраивать пароль VTY для коммутатора?**

Если не настроить пароль VTY, будет невозможно подключиться к коммутатору по протоколу Telnet

**Что нужно сделать, чтобы пароли не отправлялись в незашифрованном виде?**

Ввести команду service password-encryption
