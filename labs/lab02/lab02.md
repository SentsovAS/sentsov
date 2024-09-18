**Лабораторная работа. Просмотр таблицы MAC-адресов коммутатора**

!

!
![image](https://github.com/user-attachments/assets/de30d107-8df2-4a6b-a265-0fb57dfb5d19)


!





**Часть 1. Создание и настройка сети**

!



**Шаг 1. Подключите сеть в соответствии с топологией.**



![image](https://github.com/user-attachments/assets/4f956650-b81c-47e4-bba7-2953a62ab361)


!

**Шаг 2. Настройте узлы ПК.**

!
![image](https://github.com/user-attachments/assets/aa689989-b083-4c12-b6f0-6050ff9c9f17)


!
![image](https://github.com/user-attachments/assets/39b578ee-8f7e-4dc7-a994-5950399cc350)


!



**Шаг 3. Выполните инициализацию и перезагрузку коммутаторов.**

!

**Шаг 4. Настройте базовые параметры каждого коммутатора.**

!

S1#show running-config 

Building configuration...

Current configuration : 1229 bytes


version 15.0

no service timestamps log datetime msec

no service timestamps debug datetime msec

service password-encryption


hostname S1

enable secret 5 $1$mERr$.TzPe.s4irmwpSb5UHmGW0


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

 ip address 192.168.1.11 255.255.255.0

line con 0

 password 7 08005F1F5A48564641

 login



line vty 0 4

 password 7 08005F1F5A48564641

 login

 transport input telnet

line vty 5 15

 login
 
end

================================================

S2#show running-config 

Building configuration...


Current configuration : 1229 bytes

version 15.0

no service timestamps log datetime msec

no service timestamps debug datetime msec

service password-encryption

hostname S2

enable secret 5 $1$mERr$.TzPe.s4irmwpSb5UHmGW0

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

 ip address 192.168.1.12 255.255.255.0

 line con 0

 password 7 08005F1F5A48564641

 login
 
line vty 0 4

 password 7 08005F1F5A48564641

 login

 transport input telnet

line vty 5 15

login

end

!

**Часть 2. Изучение таблицы МАС-адресов коммутатора**

!

![image](https://github.com/user-attachments/assets/a497dc91-c59a-4fec-84ad-3faf9b31562e)


!

![image](https://github.com/user-attachments/assets/69abbf6d-b5e6-4a03-9a72-02da35b4eabb)


!

**Шаг 1. Запишите МАС-адреса сетевых устройств.**

!

**a.	Откройте командную строку на PC-A и PC-B и введите команду ipconfig /all.**

!

![image](https://github.com/user-attachments/assets/54ab91a0-2cb9-4dd5-ade5-45bbe8a64a61)


!
![image](https://github.com/user-attachments/assets/d1f86287-0213-4180-a9b8-418022929c92)


!

**Вопрос:**
**Назовите физические адреса адаптера Ethernet.**


Ответ:

MAC-адрес компьютера PC-A:000C:CF7C:31E5

MAC-адрес компьютера PC-B:000A:417D:6AA5

!
**b.	Подключитесь к коммутаторам S1 и S2 через консоль и введите команду show interface F0/1 на каждом коммутаторе**

!

![image](https://github.com/user-attachments/assets/6c33f835-eb6a-42cc-82e9-1191ca9b9d20)


!
![image](https://github.com/user-attachments/assets/49215fb5-0d37-42d4-9996-1d0558ed18f7)


!
**Назовите адреса оборудования во второй строке выходных данных команды (или зашитый адрес — bia).**

!
00d0:d32c:b201

!

00d0:bc44:a301

!

МАС-адрес коммутатора S1 Fast Ethernet 0/1: 00d0.bc44.a301
МАС-адрес коммутатора S2 Fast Ethernet 0/1: 00d0.d32c.b201

!

**Шаг 2. Просмотрите таблицу МАС-адресов коммутатора**


!
**Подключитесь к коммутатору S2 через консоль и просмотрите таблицу МАС-адресов до и после тестирования сетевой связи с помощью эхо-запросов.**

!

![image](https://github.com/user-attachments/assets/c360b397-8d05-4111-b759-04539584f32d)


после опроса в таблице появился макадрес компьютера на порту куда он подключен

!
**Записаны ли в таблице МАС-адресов какие-либо МАС-адреса?**

!
да

![image](https://github.com/user-attachments/assets/5fa42e4c-d800-49c0-a992-5356f3eebef6)



**Какие МАС-адреса записаны в таблице? С какими портами коммутатора они сопоставлены и каким устройствам принадлежат?**

00d0.d32c.b201 сопоставлены с 1 портом коммутатора, принаджежит коммутатору S1

!

**Если вы не записали МАС-адреса сетевых устройств в шаге 1, как можно определить, каким устройствам принадлежат МАС-адреса, используя только выходные данные команды show mac address-table? Работает ли это решение в любой ситуации?**

Вывод команды show mac address-table показывает порт, на котором был изучен MAC-адрес. В большинстве случаев это определит, какому сетевому устройству принадлежит MAC-адрес, за исключением случая, когда несколько MAC-адресов связаны с одним и тем же портом

!

 **Шаг 3. Очистите таблицу МАС-адресов коммутатора S2 и снова отобразите таблицу МАС-адресов.**

 !

![image](https://github.com/user-attachments/assets/d344a91e-77a3-4448-8273-51771c2b5dc6)


!
**Через 10 секунд введите команду show mac address-table и нажмите клавишу ввода. Появились ли в таблице МАС-адресов новые адреса?**

через  10 секунд снова появился адрес коммутатора s1
