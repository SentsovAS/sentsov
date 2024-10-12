
**[Лабораточная работа. Настройка IPv6-адресов на сетевых устройствах](lab04.md)**


!

![alt text](image.png)

!

**Часть 1. Настройка основных параметров устройств**

!
> Базовая настройка коммутатора

!

Enable

Conf t

Hostname S1

ip domain name sentsov.ru


crypto key generate rsa


1024

Ip ssh version 2


Username sshadmin privilege 15 secret cisco


Line console 0

Password cisco 

Login

exit

Service password-encryption

Enable secret class

Line vty 0 4

Login local

transport input ssh

transport input telnet


exit

Interface vlan 1

Ip address 192.168.1.11 255.255.255.0

No shutdown

exit

Ip default-gateway 192.168.1.1

Ctrl+z

Copy run start



!
> Базовая настройка маршрутизатора

!

Enable

Conf t

banner motd = warning=

Hostname R1

no ip domain-lookup

ip domain name sentsov.ru


crypto key generate rsa


1024


Ip ssh version 2


Username admin privilege 15 secret Adm1nP@55



Line console 0

Password cisco 

Login

exit

Service password-encryption

Enable secret class

Line vty 0 4

Login local

transport input ssh


exit

Interface gigabitethernet 0/0/1

Ip address 192.168.1.1 255.255.255.0

Ip default-gateway 192.168.1.1

No shutdown

Ctrl+z

Copy run start

!

**Шаг 4. Настройте компьютер PC-A.**

!

![alt text](image-1.png)

!

**Шаг 5. Проверьте подключение к сети.**

!

**Пошлите с PC-A команду Ping на маршрутизатор R1**

!

![alt text](image-2.png)

!

**Часть 2. Настройка маршрутизатора для доступа по протоколу SSH**

**Шаг 1. Настройте аутентификацию устройств.**

!

Hostname R1

ip domain name sentsov.ru

**Шаг 2. Создайте ключ шифрования с указанием его длины.**

!

crypto key generate rsa

1024

**Шаг 3. Создайте имя пользователя в локальной базе учетных записей.**

!

Username admin privilege 15 secret Adm1nP@55

!

**Шаг 4. Активируйте протокол SSH на линиях VTY.**

!

transport input ssh

transport input telnet

!

**Шаг 5. Сохраните текущую конфигурацию в файл загрузочной конфигурации**

!

Copy run start

**Шаг 6. Установите соединение с маршрутизатором по протоколу SSH.**

!

ssh -l admin 192.168.1.1

password: Adm1nP@55

!

**Часть 3. Настройка коммутатора для доступа по протоколу SSH**

!
Все требуемые по заданию настройки были прописаны выше в базовой настройке конфигурации 

!

**Установите соединение с коммутатором по протоколу SSH.**

!

![alt text](image-3.png)

!

**Часть 4. Настройка протокола SSH с использованием интерфейса командной строки (CLI) коммутатора**

!

**Установите с коммутатора S1 соединение с маршрутизатором R1 по протоколу SSH.**

!

![alt text](image-4.png)

!

**Какие версии протокола SSH поддерживаются при использовании интерфейса командной строки?**

версия 1 и 2

![alt text](image-5.png)

!

**Как предоставить доступ к сетевому устройству нескольким пользователям, у каждого из которых есть собственное имя пользователя?**

!

добавить имя пользователя и пароль каждого пользователя в  помощью команды username







