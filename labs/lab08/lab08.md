![image](https://github.com/user-attachments/assets/fb918f1f-0530-4dad-b561-86ab76c4033f)


**Часть 1. Создание сети и настройка основных параметров устройства**


**Шаг 1. Создайте сеть согласно топологии.**

**Шаг 2. Настройте базовые параметры каждого коммутатора. (необязательно)**

!
a.	Присвойте коммутатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Отключите все неиспользуемые порты.

i.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

!

Настройка коммутатора s1

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

login

exit

interface randge f0/1-4, f0/7-24, g0/1-2

shutdown

do copy run start

!

Настройка коммутатора s2

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

login

exit

interface randge f0/1-4, f0/6-17, f0/19-24, g0/1-2

shutdown

do copy run start


**Шаг 3. Произведите базовую настройку маршрутизаторов.**

a.	Назначьте маршрутизатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Активация IPv6-маршрутизации

i.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

!

Базовая настройка маршрутизатора R1

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

login

exit

ipv6 unicast-routing

do copy run start

!

Базовая настройка маршрутизатора R2

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

login

exit

ipv6 unicast-routing

do copy run start

!

**Шаг 4. Настройка интерфейсов и маршрутизации для обоих маршрутизаторов.**

a.	Настройте интерфейсы G0/0/0 и G0/1 на R1 и R2 с адресами IPv6, указанными в таблице выше.

b.	Настройте маршрут по умолчанию на каждом маршрутизаторе, который указывает на IP-адрес G0/0/0 на другом маршрутизаторе.

c.	Убедитесь, что маршрутизация работает с помощью пинга адреса G0/0/1 R2 из R1

d.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

!

Настройка R1

!
enable

conf t

int g0/0/0

ipv6 add 2001:db8:acad:2::1/64

ipv6 add fe80::1 link-local

no shutdown

exit

int g0/0/1

ipv6 add 2001:db8:acad:1::1/64

ipv6 add fe80::1 link-local

no shutdown

do copy run start

!

Настройка R2

!
enable

conf t

int g0/0/0

ipv6 add 2001:db8:acad:2::2/64

ipv6 add fe80::2 link-local

no shutdown

exit

int g0/0/1

ipv6 add 2001:db8:acad:3::1/64

ipv6 add fe80::1 link-local

no shutdown

do copy run start

![image](https://github.com/user-attachments/assets/2e412c87-3567-4f6c-a6a1-a1f4fe8d2134)


!

**Часть 2. Проверка назначения адреса SLAAC от R1**

В части 2 вы убедитесь, что узел PC-A получает адрес IPv6 с помощью метода SLAAC.

Включите PC-A и убедитесь, что сетевой адаптер настроен для автоматической настройки IPv6.

Через несколько минут результаты команды ipconfig должны показать, что PC-A присвоил себе адрес из сети 2001:db8:1::/64.



![image](https://github.com/user-attachments/assets/32cdbb2a-8218-4e22-afa8-76083cd32e9e)


**Часть 3. Настройка и проверка сервера DHCPv6 на R1**

В части 3 выполняется настройка и проверка состояния DHCP-сервера на R1. Цель состоит в том, чтобы предоставить PC-A информацию о DNS-сервере и домене.

**Шаг 1. Более подробно изучите конфигурацию PC-A.**

a.	Выполните команду ipconfig /all на PC-A и посмотрите на результат

![image](https://github.com/user-attachments/assets/249da6d9-bea0-49d5-a1a2-348e44dc64d4)


b.	Обратите внимание, что основной DNS-суффикс отсутствует. Также обратите внимание, что предоставленные адреса DNS-сервера являются адресами «локального сайта anycast», а не одноадресные адреса, как ожидалось.

 у меня адреса днс сервера отсутствуют


 **Шаг 2. Настройте R1 для предоставления DHCPv6 без состояния для PC-A.**

 a.	Создайте пул DHCP IPv6 на R1 с именем R1-STATELESS. В составе этого пула назначьте адрес DNS-сервера как 2001:db8:acad: :1, а имя домена — как stateless.com

 enable 

 conf t

 ipv6 dhcp pool R1-STATELESS

 dns-server 2001:db8:acad::1

 domain-name STATELESS.com

 do copy run start

 !

 b.	Настройте интерфейс G0/0/1 на R1, чтобы предоставить флаг конфигурации OTHER для локальной сети R1 и укажите только что созданный пул DHCP в качестве ресурса DHCP для этого интерфейса.

 exit
 
 interface g0/0/1

 ipv6 nd other-config-flag 

 ipv6 dhcp server R1-STATELESS

 do copy run start

 c.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

d.	Перезапустите PC-A.

e.	Проверьте вывод ipconfig /all и обратите внимание на изменения.

![image](https://github.com/user-attachments/assets/44cac4ee-b39c-4272-bcf9-a869544c5edb)


f.	Тестирование подключения с помощью пинга IP-адреса интерфейса G0/1 R2.

![image](https://github.com/user-attachments/assets/37306759-5f61-47f9-9ff3-80fd2261a1f6)


**Часть 4. Настройка сервера DHCPv6 с сохранением состояния на R1**


a.	Создайте пул DHCPv6 на R1 для сети 2001:db8:acad:3:aaa::/80. Это предоставит адреса локальной сети, подключенной к интерфейсу G0/0/1 на R2. В составе пула задайте DNS-сервер 2001:db8:acad: :254 и задайте доменное имя STATEFUL.com.

ena 

conf t

ipv6 dhcp pool R2-STATEFUL

address prefix 2001:db8:acad:3:aaa::/80

dns-server 2001:db8:acad::254

domain-name STATEFUL.com

b.	Назначьте только что созданный пул DHCPv6 интерфейсу g0/0/0 на R1.

exit

interface g0/0/0

ipv6 dhcp server R2-STATEFUL

do copy run start

**Часть 5. Настройка и проверка ретрансляции DHCPv6 на R2.**

В части 5 необходимо настроить и проверить ретрансляцию DHCPv6 на R2, позволяя PC-B получать адрес IPv6

**Шаг 1. Включите PC-B и проверьте адрес SLAAC, который он генерирует**

![image](https://github.com/user-attachments/assets/fc11da59-c500-410a-8684-80f62c69f9bf)


Обратите внимание на вывод, что используется префикс 2001:db8:acad:3::

**Шаг 2. Настройте R2 в качестве агента DHCP-ретрансляции для локальной сети на G0/0/1.**

a.	Настройте команду ipv6 dhcp relay на интерфейсе R2 G0/0/1, указав адрес назначения интерфейса G0/0/0 на R1. Также настройте команду managed-config-flag .

ena

conf t

int g0/0/1

ipv6 nd managed-config-flag

ipv6 dhcp relay destination 2001:db8:acad:2::1 g0/0/0

do copy run start

**Шаг 3. Попытка получить адрес IPv6 из DHCPv6 на PC-B.**

a.	Перезапустите PC-B.

b.	Откройте командную строку на PC-B и выполните команду ipconfig /all и проверьте выходные данные, чтобы увидеть результаты операции ретрансляции DHCPv6.

c.	Проверьте подключение с помощью пинга IP-адреса интерфейса R0 G0/0/1.







