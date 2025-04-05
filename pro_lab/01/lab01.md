# Лабораторная работа - Настройка маршрутизации между локальными сетями Router-on-a-Stick

!
![image](https://github.com/user-attachments/assets/c2792ed9-0b63-4d6d-9ccf-4abb9c058916)


![image](https://github.com/user-attachments/assets/f029720e-4159-49f1-9417-7c1a2f288b56)


# 1. Создание сети и настройка основных параметров устройств
В части 1 вы настроите топологию сети и настроите основные параметры на хостах ПК и коммутаторах.
# 1. Подключите кабели к сети, как показано на топологии.
Подключите устройства, как показано на схеме топологии, и подключите кабели по мере необходимости.
# 2. Настройте основные параметры маршрутизатора.

a.	Подключитесь к маршрутизатору с помощью консоли и активируйте привилегированный режим EXEC.

Откройте окно конфигурации

b.	Войдите в режим конфигурации.

c.	Назначьте маршрутизатору имя устройства.

d.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

e.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

f.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

g.	Установите cisco в качестве пароля виртуального терминала и активируйте вход.

h.	Зашифруйте открытые пароли.

i.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

j.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

k.	Настройте на маршрутизаторе время.




!

Enable

Conf t

Hostname R1

no ip domain-lookup

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

banner motd = warning=

Line vty 0 4

Login local

transport input ssh

Exit

exit

Clock set 19:31:00 12 mar 2025

Copy run start

!

**Шаг 3. Настройте базовые параметры каждого коммутатора.**

a.	Присвойте коммутатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Установите cisco в качестве пароля виртуального терминала и активируйте вход.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Настройте на коммутаторах время.

i.	Сохранение текущей конфигурации в качестве начальной.

!

Первый коммутатор

Enable

Conf t

Hostname S1

no ip domain-lookup

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

Banner motd =warning=

Line vty 0 4

Login local

transport input ssh telnet

Exit

exit

Clock set 19:46:00 12 mar 2025

Copy run start




!
Второй коммутатор


Enable

Conf t

Hostname S2

no ip domain-lookup

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

Banner motd =warning=

Line vty 0 4

Login local

transport input ssh telnet

Exit

Exit

Clock set 19:46:00 12 mar 2025

Copy run start



!
**Шаг 4. Настройте узлы ПК.**

!
![image](https://github.com/user-attachments/assets/68481c85-a83c-4a20-a2fc-da15629f2ebc)



!

**Часть 2. Создание сетей VLAN и назначение портов коммутатора**


Во второй части вы создадите VLAN, как указано в таблице выше, на обоих коммутаторах. Затем вы назначите VLAN соответствующему интерфейсу и проверите настройки конфигурации. Выполните следующие задачи на каждом коммутаторе.
!

**Шаг 1. Создайте сети VLAN на коммутаторах.**

a.	Создайте и назовите необходимые VLAN на каждом коммутаторе из таблицы выше.

Откройте окно конфигурации

b.	Настройте интерфейс управления и шлюз по умолчанию на каждом коммутаторе, используя информацию об IP-адресе в таблице адресации. 

c.	Назначьте все неиспользуемые порты коммутатора VLAN Parking_Lot, настройте их для статического режима доступа и административно деактивируйте их.

Примечание. Команда interface range полезна для выполнения этой задачи с минимальным количеством команд.


**Шаг 2. Назначьте сети VLAN соответствующим интерфейсам коммутатора.**

a.	Назначьте используемые порты соответствующей VLAN (указанной в таблице VLAN выше) и настройте их для режима статического доступа.
b.	Убедитесь, что VLAN назначены на правильные интерфейсы.

!


Первый коммутатор

Enable 

Conf t

Vlan 3

Name Management

Vlan 4

Name Operations

Vlan 999

Name ParkingLot

Vlan 1000

Name Native

exit

Interface vlan 3

Ip add 192.168.3.11 255.255.255.0

no shutdown

exit

Interface range e0/3

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface e0/2

switchport mode access

switchport access vlan 3

exit

ip default-gateway 192.168.3.1

no shutdown

Do copy run start



!


Второй коммутатор

Enable 

Conf t

Vlan 3

Name Management

Vlan 4

Name Operations

Vlan 999

Name ParkingLot

Vlan 1000

Name Native

exit

Interface vlan 3

Ip add 192.168.3.12 255.255.255.0

no shutdown

exit

Interface range e0/1, e0/3

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface e0/2

switchport mode access

switchport access vlan 4

ip default-gateway 192.168.3.1

no shutdown

Do copy run start


!

**Часть 3. Конфигурация магистрального канала стандарта 802.1Q между коммутаторами**

В части 3 вы вручную настроите интерфейс e0/0 как транк.
!

**Шаг 1. Вручную настройте магистральный интерфейс e0/0 на коммутаторах S1 и S2.**

a.	Настройка статического транкинга на интерфейсе e0/0 для обоих коммутаторов.

Откройте окно конфигурации

b.	Установите native VLAN 1000 на обоих коммутаторах.

c.	Укажите, что VLAN 3, 4 и 1000 могут проходить по транку.

d.	Проверьте транки, native VLAN и разрешенные VLAN через транк.

!

**Шаг 2. Вручную настройте магистральный интерфейс e0/1 на коммутаторе S1.**

a.	Настройте интерфейс S1 e0/1 с теми же параметрами транка, что и e0/0. Это транк до маршрутизатора.

b.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

c.	Проверка транкинга.

!

Первый коммутатор

interface range e0/0-1

no switchport trunk encapsulation auto

switchport trunk encapsulation dot1q

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 3,4,1000

do copy run start

do show interfaces trunk
!

Второй коммутатор


interface e0/0

no switchport trunk encapsulation auto

switchport trunk encapsulation dot1q

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 3,4,1000

do copy run start

do show interfaces trunk

!

**Часть 4. Настройка маршрутизации между сетями VLAN**

a.	При необходимости активируйте интерфейс e0/0 на маршрутизаторе.

b.	Настройте подинтерфейсы для каждой VLAN, как указано в таблице IP-адресации. Все подинтерфейсы используют инкапсуляцию 802.1Q. Убедитесь, что подинтерфейсу для native VLAN не назначен IP-адрес. Включите описание для каждого подинтерфейса.

c.	Убедитесь, что вспомогательные интерфейсы работают

!

Enable

Conf t

Interface e0/0

no shutdown

Interface e0/0.3

Description for vlan 3

Enc dot1Q 3

Ip add 192.168.3.1 255.255.255.0

No shutdown

Exit

Interface e0/0.4

Description for vlan 4

Enc dot1Q 4

Ip add 192.168.4.1 255.255.255.0

No shutdown

Exit

Interface e0/0.1000

Description for vlan native

Enc dot1Q 1000

No shutdown

Do Copy run start

!

**Часть 5. Проверьте, работает ли маршрутизация между VLAN**

!

**Шаг 1. Выполните следующие тесты с PC-A. Все должно быть успешно.**

!
**a.	Отправьте эхо-запрос с PC-A на шлюз по умолчанию.**




**b.	Отправьте эхо-запрос с PC-A на PC-B.**

!

**c.	Отправьте команду ping с компьютера PC-A на коммутатор S2.**

![image](https://github.com/user-attachments/assets/4e0705c1-d27c-4afb-ae5f-4d5104f57cfd)


!


**Шаг 2. Пройдите следующий тест с PC-B**

!

**В окне командной строки на PC-B выполните команду tracert на адрес PC-A.**

![image](https://github.com/user-attachments/assets/47524951-dac2-4a42-a7b5-3dee27bfb7e0)

!


**Какие промежуточные IP-адреса отображаются в результатах?**

1 роутер
2 компьютер pc-a






