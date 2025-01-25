![alt text](image-57.png)

# Часть 1. Создание сети и настройка основных параметров устройства

# Шаг 1. Подключите кабели сети согласно приведенной топологии

# Шаг 2. Произведите базовую настройку маршрутизаторов

a.	Назначьте маршрутизатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Настройте IP-адресации интерфейса, как указано в таблице выше.

i.	Настройте маршрут по умолчанию. от R2 до  R1.

j.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

# Базовая настройка роутера R1

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

int g0/0/0

ip add 209.165.200.230 255.255.255.248

no shutdown

exit

ip route 209.165.200.0 255.255.255.248 g0/0/0

int g0/0/1.1

Description for vlan 1

Enc dot1Q 1

ip add 192.168.1.1 255.255.255.0

no shutdown

Interface g0/0/1.1000

Description for vlan native

Enc dot1Q 1000 native

No shutdown

Exit

do copy run start

# Базовая настройка роутера R2

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

int g0/0/0

ip add 209.165.200.225 255.255.255.248

no shutdown

ip route 209.165.200.0 255.255.255.248 g0/0/0

int lo1

ip add 209.165.200.1 255.255.255.224

no shutdown

do copy run start

do show ip route

![alt text](image-58.png)


# Шаг 3. Настройте базовые параметры каждого коммутатора.

a.	Присвойте коммутатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Выключите все интерфейсы, которые не будут использоваться.

i.	Настройте IP-адресации интерфейса, как указано в таблице выше.

j.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.

# настройка коммутатора S1

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

Vlan 1

Name topc

Vlan 999

Name parkinglot

Vlan 1000

Name Native

exit

Interface vlan 1

Ip add 192.168.1.11 255.255.255.0

no shutdown

exit

int range f0/2-4, f0/7-24, g0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

int f0/6

switchport mode access

switchport access vlan 1

exit

interface range f0/1, f0/5

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 1,1000

do Copy run start

# настройка коммутатора S2

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

Vlan 1

Name topc

Vlan 999

Name parkinglot

Vlan 1000

Name Native

exit

Interface vlan 1

Ip add 192.168.1.12 255.255.255.0

no shutdown

exit

int range f0/2-17, f0/19-24, g0/1-2

Switchport mode access

Switchport access vlan 999

shutdown

exit

int f0/18

switchport mode access

switchport access vlan 1

exit

interface f0/1

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 1,1000

do Copy run start

# Часть 2. Настройка и проверка NAT для IPv4.

# Шаг 1. Настройте NAT на R1, используя пул из трех адресов 209.165.200.226-209.165.200.228. 

a.	Настройте простой список доступа, который определяет, какие хосты будут разрешены для трансляции. В этом случае все устройства в локальной сети R1 имеют право на трансляцию.
R1(config)# access-list 1 permit 192.168.1.0 0.0.0.255 

b.	Создайте пул NAT и укажите ему имя и диапазон используемых адресов.
R1(config)# ip nat pool PUBLIC_ACCESS 209.165.200.226 209.165.200.228 netmask 255.255.255.248 
Примечание. Параметр маски сети не является разделителем IP-адресов. Это должна быть правильная маска подсети для назначенных адресов, даже если вы используете не все адреса подсети в пуле. 

c.	Настройте перевод, связывая ACL и пул с процессом преобразования.
R1(config)# ip nat inside source list 1 pool PUBLIC_ACCESS 
Примечание: Три очень важных момента. Во-первых, слово «inside» имеет решающее значение для работы такого рода NAT. Если вы опустить его, NAT не будет работать. Во-вторых, номер списка — это номер ACL, настроенный на предыдущем шаге. В-третьих, имя пула чувствительно к регистру. 

d.	Задайте внутренний (inside) интерфейс. 
R1(config)# interface g0/0/1.1
R1(config-if)# ip nat inside

e.	Определите внешний (outside) интерфейс.
R1(config)# interface g0/0/0
R1(config-if)# ip nat outside

# Шаг 2. Проверьте и проверьте конфигурацию. 

a.	С PC-B,  запустите эхо-запрос интерфейса Lo1 (209.165.200.1) на R2. Если эхо-запрос не прошел, выполните процес поиска и устранения неполадок. На R1 отобразите таблицу NAT на R1 с помощью команды show ip nat translations.

R1# show ip nat translations

![alt text](image-59.png)

# Во что был транслирован внутренний локальный адрес PC-B?

в первый адрес из заданного  NAT пула = 209.165.200.226

b.	С PC-A, запустите  эхо-запрос интерфейса Lo1 (209.165.200.1) на R2. Если эхо-запрос не прошел, выполните отладку. На R1 отобразите таблицу NAT на R1 с помощью команды show ip nat translations.

R1# show ip nat translations 

![alt text](image-60.png)

c.	Обратите внимание, что предыдущая трансляция для PC-B все еще находится в таблице. Из S1, эхо-запрос интерфейса Lo1 (209.165.200.1) на R2

d.	Теперь запускаем пинг R2 Lo1 из S2. На этот раз перевод завершается неудачей, и вы получаете эти сообщения (или аналогичные) на консоли R1:

Sep 23 15:43:55.562: %IOSXE-6-PLATFORM: R0/0: cpp_cp: QFP:0.0 Thread:000 TS:00000001473688385900 %NAT-6-ADDR_ALLOC_FAILURE: Address allocation failed; pool 1 may be exhausted [2]

![alt text](image-61.png)

e.	Это ожидаемый результат, потому что выделено только 3 адреса, и мы попытались ping Lo1 с четырех устройств. Напомним, что NAT — это трансляция «один-в-один». Как много выделено трансляций? Введите команду show ip nat translations verbose , и вы увидите, что ответ будет 24 часа.

R1# show ip nat translations verbose 

Pro Inside global Inside local Outside local Outside global
--- 209.165.200.226 192.168.1.3 --- ---
  create: 09/23/19 15:35:27, use: 09/23/19 15:35:27, timeout: 23:56:42
  Map-Id(In): 1
<output omitted>
f.	Учитывая, что пул ограничен тремя адресами, NAT для пула адресов недостаточно для нашего приложения. Очистите преобразование NAT и статистику, и мы перейдем к PAT.

R1# clear ip nat translations * 

R1# clear ip nat statistics 

# Часть 3. Настройка и проверка PAT для IPv4.

# Шаг 1. Удалите команду преобразования на R1.

Компоненты конфигурации преобразования адресов в основном одинаковы; что-то (список доступа) для идентификации адресов, пригодных для перевода, дополнительно настроенный пул адресов для их преобразования и команды, необходимые для идентификации внутреннего и внешнего интерфейсов. Из части 1 наш список доступа (список доступа 1) по-прежнему корректен для сетевого сценария, поэтому нет необходимости воссоздавать его. Мы будем использовать один и тот же пул адресов, поэтому нет необходимости воссоздавать эту конфигурацию. Кроме того, внутренний и внешний интерфейсы не меняются. Чтобы начать работу в части 3, удалите команду, связывающую ACL и пул вместе.

R1(config)# no ip nat inside source list 1 pool PUBLIC_ACCESS 

# Шаг 2. Добавьте команду PAT на R1.

ip nat inside source list 1 pool PUBLIC_ACCESS overload

# Шаг 3. Протестируйте и проверьте конфигурацию.

a.	Давайте проверим, что PAT работает. С PC-B,  запустите эхо-запрос интерфейса Lo1 (209.165.200.1) на R2. Если эхо-запрос не прошел, выполните отладку. На R1 отобразите таблицу NAT на R1 с помощью команды show ip nat translations.

R1# show ip nat translations

Pro Inside global Inside local Outside local Outside global
226:1 192.168.1. 3:1 209.165.200. 1:1 209.165.200. 1:1
Total number of translations: 1#

![alt text](image-62.png)

Вопросы:
Во что был транслирован внутренний локальный адрес PC-B?
 
Какой тип адреса NAT является переведенным адресом?

Чем отличаются выходные данные команды show ip nat translations из упражнения NAT?
Введите ваш ответ здесь.
 
b.	С PC-A, запустите эхо-запрос интерфейса Lo1 (209.165.200.1) на R2. Если эхо-запрос не прошел, выполните отладку. На R1 отобразите таблицу NAT на R1 с помощью команды show ip nat translations.

R1# show ip nat translations
Pro Inside global Inside local Outside local Outside global
226:1 192.168.1. 2:1 209.165.200. 1:1 209.165.200. 1:1
Total number of translations: 1

Обратите внимание, что есть только одна трансляция. Отправьте ping еще раз, и быстро вернитесь к маршрутизатору и введите команду show ip nat translations verbose , и вы увидите, что произошло.

R1# show ip nat translations verbose 
Pro Inside global Inside local Outside local Outside global
icmp 209.165.200.226:1 192.168.1.2:1 209.165.200.1:1 209.165.200.1:1 
  create: 09/23/19 16:57:22, use: 09/23/19 16:57:25, timeout: 00:01:00
<output omitted>

Как вы можете видеть, время ожидания перевода было отменено с 24 часов до 1 минуты.

c.	Генерирует трафик с нескольких устройств для наблюдения PAT. На PC-A и PC-B используйте параметр -t с командой ping, чтобы отправить безостановочный ping на интерфейс Lo1 R2 (ping -t 209.165.200.1), затем вернитесь к R1 и выполните команду show ip nat translations:

R1# show ip nat translations
Pro Inside global Inside local Outside local Outside global
icmp 209.165.200.226:1 192.168.1.2:1 209.165.200.1:1 209.165.200.1:1 
226:2 192.168.1. 3:1 209.165.200. 1:1 209.165.200. 1:2 
Total number of translations: 2 

Обратите внимание, что внутренний глобальный адрес одинаков для обоих сеансов. 
Вопрос:
Как маршрутизатор отслеживает, куда идут ответы? 
 
d.	PAT в пул является очень эффективным решением для малых и средних организаций. Тем не менее есть неиспользуемые адреса IPv4, задействованные в этом сценарии. Мы перейдем к PAT с перегрузкой интерфейса, чтобы устранить эту трату IPv4 адресов. Остановите ping на PC-A и PC-B с помощью комбинации клавиш Control-C, затем очистите трансляции и статистику:

R1# clear ip nat translations * 

R1# clear ip nat statistics 

# Шаг 4. На R1 удалите команды преобразования nat pool.

Опять же, наш список доступа (список доступа 1) по-прежнему корректен для сетевого сценария, поэтому нет необходимости воссоздавать его. Кроме того, внутренний и внешний интерфейсы не меняются. Чтобы начать работу с PAT к интерфейсу, очистите конфигурацию, удалив пул NAT и команду, связывающую ACL и пул вместе.

R1(config)# no ip nat inside source list 1 pool PUBLIC_ACCESS overload 

R1(config)# no ip nat pool PUBLIC_ACCESS

# Шаг 5. Добавьте команду PAT overload, указав внешний интерфейс.

Добавьте команду PAT, которая вызовет перегрузку внешнего интерфейса.

R1(config)# ip nat inside source list 1 interface g0/0/0 overload 

# Шаг 6. Протестируйте и проверьте конфигурацию. 

a.	Давайте проверим PAT, чтобы интерфейс работал. С PC-B,  запустите эхо-запрос интерфейса Lo1 (209.165.200.1) на R2. Если эхо-запрос не прошел, выполните отладку. На R1 отобразите таблицу NAT на R1 с помощью команды 
show ip nat translations.

R1# show ip nat translations

Pro Inside global Inside local Outside local Outside global
209.165.200. 230:1 192.168.1. 3:1 209.165.200. 1:1 209.165.200. 1:1 
Total number of translations: 1 

![alt text](image-63.png)

b.	Сделайте трафик с нескольких устройств для наблюдения PAT. На PC-A и PC-B используйте параметр -t с командой ping для отправки безостановочного ping на интерфейс Lo1 R2 (ping -t 209.165.200.1). На S1 и S2 выполните привилегированную команду exec ping 209.165.200.1 повторить 2000. Затем вернитесь к R1 и выполните команду show ip nat translations.

R1# show ip nat translations

![alt text](image-64.png)

Теперь все внутренние глобальные адреса сопоставляются с IP-адресом интерфейса g0/0/0.
Остановите все пинги. На PC-A и PC-B, используя комбинацию клавиш CTRL-C.

# Часть 4. Настройка и проверка статического NAT для IPv4.

В части 4 будет настроена статическая NAT таким образом, чтобы PC-A был доступен напрямую из Интернета. PC-A будет доступен из R2 по адресу 209.165.200.229.
Примечание. Конфигурация, которую вы собираетесь завершить, не соответствует рекомендуемым практикам для шлюзов, подключенных к Интернету. Эта лаборатория полностью опускает стандартные методы безопасности, чтобы сосредоточиться на успешной конфигурации статического NAT. В производственной среде решающее значение для удовлетворения этого требования будет иметь тщательная координация между сетевой инфраструктурой и группами безопасности

# Шаг 1. На R1 очистите текущие трансляции и статистику.

clear ip nat translations * 

R1# clear ip nat statistics 

# Шаг 2. На R1 настройте команду NAT, необходимую для статического сопоставления внутреннего адреса с внешним адресом.

Для этого шага настройте статическое сопоставление между 192.168.1.11 и 209.165.200.1 с помощью следующей команды:

ip nat inside source static 192.168.1.2 209.165.200.229 

# Шаг 3. Протестируйте и проверьте конфигурацию.

a.	Давайте проверим, что статический NAT работает. На R1 отобразите таблицу NAT на R1 с помощью команды show ip nat translations, и вы увидите статическое сопоставление.

R1# show ip nat translations

Pro Inside global Inside local Outside local Outside global
--- 209.165.200.229 192.168.1.2 --- ---
Total number of translations: 1

![](image-65.png)

b.	Таблица перевода показывает, что статическое преобразование действует. Проверьте это, запустив ping  с R2 на 209.165.200.229. Плинги должны работать.

![alt text](image-66.png)

c.	На R1 отобразите таблицу NAT на R1 с помощью команды show ip nat translations, и вы увидите статическое сопоставление и преобразование на уровне порта для входящих pings.

R1# show ip nat translations


![alt text](image-67.png)