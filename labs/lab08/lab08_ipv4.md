![image](https://github.com/user-attachments/assets/37ffd25d-1961-4b8e-b651-0c8535a3433d)


!

**Часть 1. Создание сети и настройка основных параметров устройства
В первой части лабораторной работы вам предстоит создать топологию сети и настроить базовые параметры для узлов ПК и коммутаторов.**

!
**Шаг 1.	Создание схемы адресации**

Подсеть сети 192.168.1.0/24 в соответствии со следующими требованиями:

a.	Одна подсеть «Подсеть A», поддерживающая 58 хостов (клиентская VLAN на R1).

Подсеть A

Запишите первый IP-адрес в таблице адресации для R1 G0/0/1.100 . 

!
192.168.1.2 255.255.255.192

b.	Одна подсеть «Подсеть B», поддерживающая 28 хостов (управляющая VLAN на R1). 

Подсеть B:

Запишите первый IP-адрес в таблице адресации для R1 G0/0/1.200. 

192.168.1.193 255.255.255.224

Запишите второй IP-адрес в таблице адресов для S1 VLAN 200 и введите соответствующий шлюз по умолчанию.

192.168.1.194 255.255.255.224

шлюз 192.168.1.1


c.	Одна подсеть «Подсеть C», поддерживающая 12 узлов (клиентская сеть на R2).

Подсеть C:

Запишите первый IP-адрес в таблице адресации для R2 G0/0/1.

192.168.1.225  255.255.255.240

!
**Шаг 2.	Создайте сеть согласно топологии.**

Подключите устройства, как показано в топологии, и подсоедините необходимые кабели.

**Шаг 3.	Произведите базовую настройку маршрутизаторов.**

a.	Назначьте маршрутизатору имя устройства.
Откройте окно конфигурации

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

i.	Установите часы на маршрутизаторе на сегодняшнее время и дату.



Базовая настройка роутера R1

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

Clock set 19:31:00 19 nov 2024

Copy run start

Базовая настройка роутера R2

Enable

Conf t

Hostname R2

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

Clock set 19:32:00 19 nov 2024

Copy run start

**Шаг 4.	Настройка маршрутизации между сетями VLAN на маршрутизаторе R1**

!

a.	Активируйте интерфейс G0/0/1 на маршрутизаторе.

b.	Настройте подинтерфейсы для каждой VLAN в соответствии с требованиями таблицы IP-адресации. Все субинтерфейсы используют инкапсуляцию 802.1Q и назначаются первый полезный адрес из вычисленного пула IP-адресов. Убедитесь, что подинтерфейсу для native VLAN не назначен IP-адрес. Включите описание для каждого подинтерфейса.

c.	Убедитесь, что вспомогательные интерфейсы работают.

!
R1

conf t

Interface g0/0/1.100

Description for vlan 100

Enc dot1Q 100

Ip add 192.168.1.1 255.255.255.192

No shutdown

Exit

Interface g0/0/1.200

Description for vlan 200

Enc dot1Q 200

Ip add 192.168.1.193 255.255.255.0

No shutdown

Exit

Interface g0/0/1.1000

Description for vlan native

Enc dot1Q 1000

No shutdown

Do Copy run start


!

**Шаг 5.	Настройте G0/1 на R2, затем G0/0/0 и статическую маршрутизацию для обоих маршрутизаторов**

a.	Настройте G0/0/1 на R2 с первым IP-адресом подсети C, рассчитанным ранее.

b.	Настройте интерфейс G0/0/0 для каждого маршрутизатора на основе приведенной выше таблицы IP-адресации.

c.	Настройте маршрут по умолчанию на каждом маршрутизаторе, указываемом на IP-адрес G0/0/0 на другом маршрутизаторе.

d.	Убедитесь, что статическая маршрутизация работает с помощью пинга до адреса G0/0/1 R2 от R1.

e.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

R1

Interface g0/0/0

ip add 10.0.0.1 255.255.255.252

No shutdown

ip default-gateway 10.0.0.2

do copy run start

R2

conf t

int g0/0/0

ip add 10.0.0.2 255.255.255.252

No shutdown

ip default-gateway 10.0.0.1

exit

int g0/0/1

ip add 192.168.1.225  255.255.255.240

no shutdown

do copy run start

![image](https://github.com/user-attachments/assets/682367e2-fabc-44eb-991c-daf897b1ba6b)


!

**Шаг 6.	Настройте базовые параметры каждого коммутатора.**


Базовая настройка роутера s1
!
Enable

Conf t

Hostname s1

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

Clock set 19:345:00 19 nov 2024

Copy run start

Базовая настройка роутера s2

Enable

Conf t

Hostname s2

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

Clock set 19:50:00 19 nov 2024

Copy run start


**Шаг 7.	Создайте сети VLAN на коммутаторе S1.**

a.	Создайте необходимые VLAN на коммутаторе 1 и присвойте им имена из приведенной выше таблицы.

b.	Настройте и активируйте интерфейс управления на S1 (VLAN 200), используя второй IP-адрес из подсети, рассчитанный ранее. Кроме того установите шлюз по умолчанию на S1.

c.	Настройте и активируйте интерфейс управления на S2 (VLAN 1), используя второй IP-адрес из подсети, рассчитанный ранее. Кроме того, установите шлюз по умолчанию на S2

d.	Назначьте все неиспользуемые порты S1 VLAN Parking_Lot, настройте их для статического режима доступа и административно деактивируйте их. На S2 административно деактивируйте все неиспользуемые порты.

Первый коммутатор

Enable 

Conf t

Vlan 100  f0/6

Name clients

Vlan 200

Name Control

Vlan 999 F0/1-4, F0/7-24, G0/1-2

Name Parking_Lot

Vlan 1000

Name Native

exit

Interface vlan 200

Ip add 192.168.1.194 255.255.255.224

ip default-gateway 192.168.1.1

exit

Interface range F0/1-4, F0/7-24, G0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface f0/6

switchport mode access

switchport access vlan 100

Do copy run start



!


Второй коммутатор

Enable 

Conf t

Vlan 1

Vlan 1000

Name Native

exit

Interface vlan 1

Ip add 192.168.1.194 255.255.255.224

ip default-gateway 192.168.1.1

exit

interface f0/18

switchport mode access

switchport access vlan 1

exit

Interface range f0/1-4, f0/6-17, f0/19-24, g0/1-2

shutdawn

Do copy run start

**Шаг 8.	Назначьте сети VLAN соответствующим интерфейсам коммутатора.**

a.	Назначьте используемые порты соответствующей VLAN (указанной в таблице VLAN выше) и настройте их для режима статического доступа.
Откройте окно конфигурации

b.	Убедитесь, что VLAN назначены на правильные интерфейсы.
Вопрос:

Почему интерфейс F0/5 указан в VLAN 1?

Потому что он установлен на всех портах коммутатора по умолчанию

**Шаг 9.	Вручную настройте интерфейс S1 F0/5 в качестве транка 802.1Q.**

a.	Измените режим порта коммутатора, чтобы принудительно создать магистральный канал.

b.	В рамках конфигурации транка  установите для native  VLAN значение 1000.

c.	В качестве другой части конфигурации магистрали укажите, что VLAN 100, 200 и 1000 могут проходить по транку.

d.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

e.	Проверьте состояние транка.

Вопрос:
Какой IP-адрес был бы у ПК, если бы он был подключен к сети с помощью DHCP?

interface f0/5

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 100,200,1000

do copy run start

do show interface trunk

![image](https://github.com/user-attachments/assets/11ef8dc7-2164-4ca2-b99e-82740373ffd1)


**Какой IP-адрес был бы у ПК, если бы он был подключен к сети с помощью DHCP?**

 192.168.1.195

**Часть 2.	Настройка и проверка двух серверов DHCPv4 на R1**

В части 2 необходимо настроить и проверить сервер DHCPv4 на R1. Сервер DHCPv4 будет обслуживать две подсети, подсеть A и подсеть C

**Шаг 1.	Настройте R1 с пулами DHCPv4 для двух поддерживаемых подсетей. Ниже приведен только пул DHCP для подсети A**

a.	Исключите первые пять используемых адресов из каждого пула адресов.
Откройте окно конфигурации

b.	Создайте пул DHCP (используйте уникальное имя для каждого пула).

c.	Укажите сеть, поддерживающую этот DHCP-сервер.

d.	В качестве имени домена укажите CCNA-lab.com.

e.	Настройте соответствующий шлюз по умолчанию для каждого пула DHCP.

f.	Настройте время аренды на 2 дня 12 часов и 30 минут.

g.	Затем настройте второй пул DHCPv4, используя имя пула R2_Client_LAN и вычислите сеть, маршрутизатор по умолчанию, и используйте то же имя домена и время аренды, что и предыдущий пул DHCP.

!

conf t

ip dhcp excluded-address 192.168.1.1 192.168.1.6

ip dhcp excluded-address 192.168.1.192 192.168.1.197

ip dhcp excluded-address 192.168.1.224 192.168.1.229

ip dhcp pool R1_CLIENTS_LAN

network 192.168.1.0 255.255.255.0

defoult-router 192.168.1.1

dns-server 192.168.1.1

domen-name CCNA-lab.com

lease 2 12 30

exit

ip dhcp pool R1_CONTROL_LAN

network 192.168.1.192 255.255.255.192

defoult-router 192.168.1.1

dns-server 192.168.1.1

domen-name CCNA-lab.com

lease 2 12 30

exit

ip dhcp pool R1_NATIVE_LAN

network 192.168.1.224 255.255.255.240

defoult-router 192.168.1.1

dns-server 192.168.1.1

domen-name CCNA-lab.com

lease 2 12 30

do copy run start

пункт g не понял

**Шаг 3.	Проверка конфигурации сервера DHCPv4**
a.	Чтобы просмотреть сведения о пуле, выполните команду show ip dhcp pool .

b.	Выполните команду show ip dhcp bindings для проверки установленных назначений адресов DHCP.

c.	Выполните команду show ip dhcp server statistics для проверки сообщений DHCP.

show ip dhcp pool 

![image](https://github.com/user-attachments/assets/e16446f0-09be-4504-a025-f513623c143f)


show ip dhcp binding 

show ip dhcp server statistics 

![image](https://github.com/user-attachments/assets/41a51980-6fd6-4a86-a10b-0a3e9b93ba0a)


dhcp binding ничего не обнаружила, а последняя команда не работает ((


**Шаг 4.	Попытка получить IP-адрес от DHCP на PC-A**

a.	Из командной строки компьютера PC-A выполните команду ipconfig /all.

b.	После завершения процесса обновления выполните команду ipconfig для просмотра новой информации об IP-адресе.

c.	Проверьте подключение с помощью пинга IP-адреса интерфейса R0 G0/0/1.

