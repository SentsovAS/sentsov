![image](https://github.com/user-attachments/assets/af624cc4-aacb-47eb-9497-57336d91a889)


![image](https://github.com/user-attachments/assets/9850e412-979e-414f-a84a-b1cc4b899834)


![image](https://github.com/user-attachments/assets/d3928f4e-efc1-4b47-afb9-702b21ada432)


# Часть 1. Создание сети и настройка основных параметров устройства

# Шаг 1. Создайте сеть согласно топологии.

Подключите устройства, как показано в топологии, и подсоедините необходимые кабели.

# Шаг 2. Произведите базовую настройку маршрутизаторов.

a.	Назначьте маршрутизатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

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

password cisco

Login 

Exit

do Copy run start

!

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

password cisco

Login

Exit

Copy run start

# Шаг 3. Настройте базовые параметры каждого коммутатора.

a.	Присвойте коммутатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

Базовая настройка коммутатора S1

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

do Copy run start

!

Базовая настройка коммутатора S2

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

Copy run start

# Часть 2. Настройка сетей VLAN на коммутаторах.

# Шаг 1. Создайте сети VLAN на коммутаторах.

a.	Создайте необходимые VLAN и назовите их на каждом коммутаторе из приведенной выше таблицы.

b.	Настройте интерфейс управления и шлюз по умолчанию на каждом коммутаторе, используя информацию об IP-адресе в таблице адресации. 

c.	Назначьте все неиспользуемые порты коммутатора VLAN Parking Lot, настройте их для статического режима доступа и административно деактивируйте их.

Первый коммутатор

Enable 

Conf t

Vlan 20

Name Management

Vlan 30

Name Operations

Vlan 40

Name Sales

Vlan 999

Name ParkingLot

Vlan 1000

Name Native

exit

Interface vlan 20

Ip add 10.20.0.2 255.255.255.0

exit

Interface range F0/2-4, F0/7-24, G0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

ip default-gateway 10.20.0.1  (для реального коммутатора команда ip route 10.20.0.1)

Do copy run start


Второй коммутатор

Enable 

Conf t

Vlan 20

Name Management

Vlan 30

Name Operations

Vlan 40

Name Sales

Vlan 999

Name ParkingLot

Vlan 1000

Name Native

exit

Interface vlan 20

Ip add 10.20.0.3 255.255.255.0

exit

Interface range F0/2-4, F0/6-17, F0/19-24, G0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

ip default-gateway 10.20.0.1  (для реального коммутатора команда ip route 10.20.0.1)

Do copy run start


# Шаг 2. Назначьте сети VLAN соответствующим интерфейсам коммутатора.

a.	Назначьте используемые порты соответствующей VLAN (указанной в таблице VLAN выше) и настройте их для режима статического доступа.

b.	Выполните команду show vlan brief, чтобы убедиться, что сети VLAN назначены правильным интерфейсам.


Первый коммутатор

exit

interface f0/6

switchport mode access

switchport access vlan 30

Do copy run start

exit

show vlan brief

![image](https://github.com/user-attachments/assets/f3d65f57-6c6f-4f7d-be49-7262f0d15092)


!

Второй коммутатор

interface f0/5

switchport mode access

switchport access vlan 20

exit

interface f0/18

switchport mode access

switchport access vlan 40

Do copy run start

show vlan brief

![image](https://github.com/user-attachments/assets/b9f7b2f6-fe00-4cfb-bcc1-639eb49072c2)



# Часть 3. ·Настройте транки (магистральные каналы).

# Шаг 1. Вручную настройте магистральный интерфейс F0/1.

a.	Измените режим порта коммутатора на интерфейсе F0/1, чтобы принудительно создать магистральную связь. Не забудьте сделать это на обоих коммутаторах.

b.	В рамках конфигурации транка установите для native vlan значение 1000 на обоих коммутаторах. При настройке двух интерфейсов для разных собственных VLAN сообщения об ошибках могут отображаться временно.

c.	В качестве другой части конфигурации транка укажите, что VLAN 20, 30, 40 и 1000 разрешены в транке.

d.	Выполните команду show interfaces trunk для проверки портов магистрали, собственной VLAN и разрешенных VLAN через магистраль.

Первый коммутатор

interface f0/1

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 20,30,40,1000

do copy run start

do show interfaces trunk

![image](https://github.com/user-attachments/assets/fb69af0d-2136-4cab-8456-d7c009db2486)


!

Второй коммутатор

interface f0/1

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 20,30,40,1000

do copy run start

do show interfaces trunk

![image](https://github.com/user-attachments/assets/b6657379-bee9-4045-a46f-efcc0c8b1e9d)


# Шаг 2. Вручную настройте магистральный интерфейс F0/5 на коммутаторе S1.

a.	Настройте интерфейс S1 F0/5 с теми же параметрами транка, что и F0/1. Это транк до маршрутизатора.

b.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

c.	Используйте команду show interfaces trunk для проверки настроек транка.


interface f0/5

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 20,30,40,1000

do copy run start

do show interfaces trunk

![image](https://github.com/user-attachments/assets/a5a8f2a4-7ef7-4103-bb8f-45c7e21d7175)




# Часть 4. Настройте маршрутизацию.

# Шаг 1. Настройка маршрутизации между сетями VLAN на R1.

a.	Активируйте интерфейс G0/0/1 на маршрутизаторе.

b.	Настройте подинтерфейсы для каждой VLAN, как указано в таблице IP-адресации. Все подинтерфейсы используют инкапсуляцию 802.1Q. Убедитесь, что подинтерфейс для собственной VLAN не имеет назначенного IP-адреса. Включите описание для каждого подинтерфейса.

c.	Настройте интерфейс Loopback 1 на R1 с адресацией из приведенной выше таблицы.

d.	С помощью команды show ip interface brief проверьте конфигурацию подынтерфейса.

Conf t

Interface g0/0/1.20

Description for vlan 20

Enc dot1Q 20

Ip add 10.20.0.1 255.255.255.0

No shutdown

Exit

Interface g0/0/1.30

Description for vlan 30

Enc dot1Q 30

Ip add 10.30.0.1 255.255.255.0

No shutdown

Exit

Interface g0/0/1.40

Description for vlan 40

Enc dot1Q 40

Ip add 10.40.0.1 255.255.255.0

No shutdown

Exit

Interface g0/0/1.1000

Description for vlan native

Enc dot1Q 1000 native

No shutdown

Exit

Interface g0/0/1

No shutdown

int lo1

ip add 172.16.1.1 255.255.255.0

Do Copy run start

do show ip interface brief

![image](https://github.com/user-attachments/assets/50e1c74a-bd7f-4f36-8c93-87b4d40991db)



# Шаг 2. Настройка интерфейса R2 g0/0/1 с использованием адреса из таблицы и маршрута по умолчанию с адресом следующего перехода 10.20.0.1

conf t

Interface g0/0/1

ip add 10.20.0.4 255.255.255.0

exit

ip route 10.20.0.1 255.255.255.0 g0/0/1

do copy run start

# Часть 5. Настройте удаленный доступ

# Шаг 1. Настройте все сетевые устройства для базовой поддержки SSH.

a.	Создайте локального пользователя с именем пользователя SSHadmin и зашифрованным паролем $cisco123!

b.	Используйте ccna-lab.com в качестве доменного имени.

c.	Генерируйте криптоключи с помощью 1024 битного модуля.

d.	Настройте первые пять линий VTY на каждом устройстве, чтобы поддерживать только SSH-соединения и с локальной аутентификацией.

conf t

ip domain name ccna-lab.com

crypto key generate rsa

1024

Ip ssh version 2

Username sshadmin privilege 15 secret $cisco123!

Line vty 0 4

Login local

transport input ssh

# Шаг 2. Включите защищенные веб-службы с проверкой подлинности на R1.

a.	Включите сервер HTTPS на R1.

R1(config)# ip http secure-server 

b.	Настройте R1 для проверки подлинности пользователей, пытающихся подключиться к веб-серверу.

R1(config)# ip http authentication local

# Часть 6. Проверка подключения

# Шаг 1. Настройте узлы ПК.

Адреса ПК можно посмотреть в таблице адресации.

![image](https://github.com/user-attachments/assets/61535c61-8cce-4ad6-b5c1-80904f6f3c04)


![image](https://github.com/user-attachments/assets/de59af74-1f86-412a-9275-01e16631dc05)


# Шаг 2. Выполните следующие тесты. Эхозапрос должен пройти успешно.

![image](https://github.com/user-attachments/assets/857945cf-0e3a-4d75-9fbe-48678d560111)


![image](https://github.com/user-attachments/assets/051f02c4-752c-4211-b9ac-5edeef8dc286)


![image](https://github.com/user-attachments/assets/e515cb1a-8ba9-4987-a79d-ffad799b2d86)


по ssh на 10.20.0.1 и 172.16.1.1 заходит

![image](https://github.com/user-attachments/assets/d77c2e62-c61f-452c-8a23-ded40a610101)


# Часть 7. Настройка и проверка списков контроля доступа (ACL)

При проверке базового подключения компания требует реализации следующих политик безопасности:

Политика1. Сеть Sales не может использовать SSH в сети Management (но в  другие сети SSH разрешен). 

Политика 2. Сеть Sales не имеет доступа к IP-адресам в сети Management с помощью любого веб-протокола (HTTP/HTTPS). Сеть Sales также не имеет доступа к интерфейсам R1 с помощью любого веб-протокола. Разрешён весь другой веб-трафик (обратите внимание — Сеть Sales  может получить доступ к интерфейсу Loopback 1 на R1).

Политика3. Сеть Sales не может отправлять эхо-запросы ICMP в сети Operations или Management. Разрешены эхо-запросы ICMP к другим адресатам. 

Политика 4: Cеть Operations  не может отправлять ICMP эхозапросы в сеть Sales. Разрешены эхо-запросы ICMP к другим адресатам. 

# remark - описание, deny - запретить, permit - разрешить, eq - равный

# Расширенные листы доступа ACL
# пример access-list 2 permit tcp any 192.168.1.0 0.0.0.255 eq 80  (http)
# access-list 2 permit tcp any (куда) 192.168.1.0 0.0.0.255 (откуда) established
# int f0/1 
# ip access-group out

# access-list 2 permit tcp any (кто\кому) any (куда) eq 443 (https)
# access-list 2 permit tcp any any eq 22 (ssh)
# show access-lists показывает информацию о акцес листах с указанием номера строки 
# show running-config показывает акцес листы с описанием-remark, но без номеров строк

1. правило
conf t

access-list 1 remark for vlan 40 Deny SSH on vlan 20

access-list 1 deny 

или правильнее

ip access-list standart SSH-Deny

remark for vlan 40 Deny SSH on vlan 20

deny host 10.20.0.0 0.0.0.255

permit any

exit

Роутер R2

conf t

line vty 0 4

ip access-list group SSH-Deny in

или ip access-group SSH-Deny in

или

access-class 1 in




# Политика 2. Сеть Sales не имеет доступа к IP-адресам в сети Management с помощью любого веб-протокола (HTTP/HTTPS). 

роутер 1

2. правило

ip access-list extended HTTP-Deny

remark for vlan 40 Deny HTTP on vlan 20

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 80

permit tcp 10.40.0.0 0.0.0.255 any

exit

!

ip access-list extended HTTPS-Deny

remark for vlan 40 Deny HTTPS on vlan 20

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 443

permit tcp 10.40.0.0 0.0.0.255 any

exit

int range g0/0/1.20,g0/0/1.30,lo1

ip access-group HTTP-Deny in

ip access-group HTTPS-Deny in


# Сеть Sales также не имеет доступа к интерфейсам R1 с помощью любого веб-протокола. Разрешён весь другой веб-трафик (обратите внимание — Сеть Sales  может получить доступ к интерфейсу Loopback 1 на R1).

!

ip access-list extended Sales-Deny-Any

remark for vlan 40 Deny Any Web

deny tcp 10.40.0.0 0.0.0.255 host 10.20.0.1 eq 80

deny tcp 10.40.0.0 0.0.0.255 host 10.20.0.1 eq 443

deny tcp 10.40.0.0 0.0.0.255 host 10.30.0.1 eq 80

deny tcp 10.40.0.0 0.0.0.255 host 10.30.0.1 eq 443

deny tcp 10.40.0.0 0.0.0.255 host 172.16.1.1 eq 80

deny tcp 10.40.0.0 0.0.0.255 host 172.16.1.1 eq 443

permit tcp 10.40.0.0 0.0.0.255 any

exit

int range g0/0/1.20,g0/0/1.30,lo1

ip access-group Sales-Deny-Any in


# Политика3. Сеть Sales не может отправлять эхо-запросы ICMP в сети Operations или Management. Разрешены эхо-запросы ICMP к другим адресатам.


ip access-list extended Sales-Deny-Echo

remark for vlan 40 Deny Echo on vlan 20 and vlan 30

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 echo (icmp)

deny tcp 10.40.0.0 0.0.0.255 10.30.0.0 0.0.0.255 echo

permit 10.40.0.0 0.0.0.255 any echo

int range g0/0/1.20,g0/0/1.30

ip access-group Sales-Deny-Echo in

# Политика 4: Cеть Operations  не может отправлять ICMP эхозапросы в сеть Sales. Разрешены эхо-запросы ICMP к другим адресатам.

ip access-list extended Operations-Deny-Echo

remark for vlan 30 Deny-Echo on vlan 40

deny tcp 10.30.0.0 0.0.0.255 10.40.0.0 0.0.0.255 echo

permit tcp 10.30.0.0 0.0.0.255 10.20.0.0 0.0.0.255 echo

dpermit tcp 10.30.0.0 0.0.0.255 host 172.16.1.1 echo

int range g0/0/1.40,g0/0/1.20,lo1

ip access-group Operations-Deny-Echo in
