![image](https://github.com/user-attachments/assets/8a286c7f-9355-454f-a5aa-449f8f450f3b)


![image](https://github.com/user-attachments/assets/1561ca12-a7bf-4fc8-8aa4-ef9c73314541)


![image](https://github.com/user-attachments/assets/49b47aad-af15-473b-a21f-175045136533)


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

![image](https://github.com/user-attachments/assets/88972d95-4f76-41a4-b0bc-5cb7df4797d9)


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

![image](https://github.com/user-attachments/assets/67ccfcb6-ca77-444e-b943-6d73def34ab7)



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

![image](https://github.com/user-attachments/assets/76ca0196-5386-45c7-ada5-07e3a5a7d90b)


!

Второй коммутатор

interface f0/1

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 20,30,40,1000

do copy run start

do show interfaces trunk

![image](https://github.com/user-attachments/assets/248e400e-7be6-4965-a282-08be966c44df)


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

![image](https://github.com/user-attachments/assets/12ad7163-d35a-4791-ac85-0f21938ab5fa)




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

![image](https://github.com/user-attachments/assets/07bbff5f-e81f-4d41-ac96-247b7459e36c)



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

![image](https://github.com/user-attachments/assets/2202be55-060a-4f1e-b1a0-9c9a79e390ba)



![image](https://github.com/user-attachments/assets/b8779bb1-af84-44e4-916b-f64c132e677e)



# Шаг 2. Выполните следующие тесты. Эхозапрос должен пройти успешно.

![image](https://github.com/user-attachments/assets/67c071f8-82ad-46f0-be25-84a41f9bd28e)



![image](https://github.com/user-attachments/assets/95ba3364-0217-4123-bb55-9a276c60236a)



![image](https://github.com/user-attachments/assets/5dd19a3d-4a56-410b-a862-19a0a41cd935)


по ssh на 10.20.0.1 и 172.16.1.1 заходит

![image](https://github.com/user-attachments/assets/9f2baf81-6a41-4ebf-837a-0fe09f54c069)


# Часть 7. Настройка и проверка списков контроля доступа (ACL)

При проверке базового подключения компания требует реализации следующих политик безопасности:

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

# 1. Политика1. Сеть Sales не может использовать SSH в сети Management (но в  другие сети SSH разрешен). 

# Политика 2. Сеть Sales не имеет доступа к IP-адресам в сети Management с помощью любого веб-протокола (HTTP/HTTPS). 
# Сеть Sales также не имеет доступа к интерфейсам R1 с помощью любого веб-протокола. Разрешён весь другой веб-трафик (обратите внимание — Сеть Sales  может получить доступ к интерфейсу Loopback 1 на R1).

# Политика 3. Сеть Sales не может отправлять эхо-запросы ICMP в сети Operations или Management. Разрешены эхо-запросы ICMP к другим адресатам.

# R1

ip access-list ext DENY_SSH_HTTP_HTTPS_ECHO

remark DENY SSH HTTP HTTPS ECHO

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 22

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 80

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 443

deny icmp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 echo 

deny icmp 10.40.0.0 0.0.0.255 10.30.0.0 0.0.0.255 echo

permit ip any any

exit

int g0/0/1.40

ip access-group DENY_SSH_HTTP_HTTPS_ECHO in

# R2

ip access-list ext DENY_SSH_HTTP_HTTPS_ECHO

remark DENY SSH HTTP HTTPS ECHO

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 22

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 80

deny tcp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 eq 443

deny icmp 10.40.0.0 0.0.0.255 10.20.0.0 0.0.0.255 echo 

deny icmp 10.40.0.0 0.0.0.255 10.30.0.0 0.0.0.255 echo

permit ip any any

exit

int g0/0/1

ip access-group DENY_SSH_HTTP_HTTPS_ECHO in

# Политика 4: Cеть Operations  не может отправлять ICMP эхозапросы в сеть Sales. Разрешены эхо-запросы ICMP к другим адресатам.

ip access-list extended VLAN30_DENY_ECHO_VLAN40

remark for Vlan 30 Deny-Echo on Vlan 40

deny icmp 10.30.0.0 0.0.0.255 10.40.0.0 0.0.0.255 echo

permit ip any any

exit 

int range g0/0/1.30

ip access-group VLAN30_DENY_ECHO_VLAN40 in

# Шаг 1. Проанализируйте требования к сети и политике безопасности для планирования реализации ACL.

# Шаг 2. Разработка и применение расширенных списков доступа, которые будут соответствовать требованиям политики безопасности.

# Шаг 3. Убедитесь, что политики безопасности применяются развернутыми списками доступа.

![image](https://github.com/user-attachments/assets/a4d73451-0fa5-44b6-98cf-92dc11178fe8)


PC-A

![image](https://github.com/user-attachments/assets/58c7c0ae-d39e-4440-8829-07a8770369dd)


PC-B

![image](https://github.com/user-attachments/assets/a69473ee-09de-4085-b86c-fbd8eda476e0)


SSH 10.20.0.4

![image](https://github.com/user-attachments/assets/45147c50-ffa0-4adc-882e-3dd33e50edf1)


SSH 172.16.1.1

![image](https://github.com/user-attachments/assets/a5e1bd8a-2b96-48b9-a072-706de05f3657)


