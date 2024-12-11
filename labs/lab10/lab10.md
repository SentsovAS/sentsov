**Лабораторная работа. Настройка протокола OSPFv2 для одной области**

![alt text](image-31.png)

**Часть 1. Создание сети и настройка основных параметров устройства**

**Шаг 1. Создайте сеть согласно топологии.**

**Шаг 2. Произведите базовую настройку маршрутизаторов.**

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

exit

Clock set 19:31:00 11 dec 2024

Copy run start

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

exit

Clock set 19:32:00 11 dec 2024

Copy run start

**Шаг 3. Настройте базовые параметры каждого коммутатора.**

a.	Назначьте коммутатору имя устройства.

b.	Отключите поиск DNS, чтобы предотвратить попытки маршрутизатора неверно преобразовывать введенные команды таким образом, как будто они являются именами узлов.

c.	Назначьте class в качестве зашифрованного пароля привилегированного режима EXEC.

d.	Назначьте cisco в качестве пароля консоли и включите вход в систему по паролю.

e.	Назначьте cisco в качестве пароля VTY и включите вход в систему по паролю.

f.	Зашифруйте открытые пароли.

g.	Создайте баннер с предупреждением о запрете несанкционированного доступа к устройству.

h.	Сохраните текущую конфигурацию в файл загрузочной конфигурации.



Базовая настройка коммутатора s1
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

password cisco

Login

Exit

exit

Clock set 19:35:00 11 dec 2024

Copy run start

Базовая настройка коммутатора s2

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

password cisco

Login 

Exit

exit

Clock set 19:50:00 11 dec 2024

Copy run start


**Часть 2. Настройка и проверка базовой работы протокола OSPFv2 для одной области**

**Шаг 1. Настройте адреса интерфейса и базового OSPFv2 на каждом маршрутизаторе.**

a.	Настройте адреса интерфейсов на каждом маршрутизаторе, как показано в таблице адресации выше.

Откройте окно конфигурации

b.	Перейдите в режим конфигурации маршрутизатора OSPF, используя идентификатор процесса 56.

c.	Настройте статический идентификатор маршрутизатора для каждого маршрутизатора (1.1.1.1 для R1, 2.2.2.2 для R2).

d.	Настройте инструкцию сети для сети между R1 и R2, поместив ее в область 0.

e.	Только на R2 добавьте конфигурацию, необходимую для объявления сети Loopback 1 в область OSPF 0.

f.	Убедитесь, что OSPFv2 работает между маршрутизаторами. Выполните команду, чтобы убедиться, что R1 и R2 сформировали смежность.

Вопрос: Какой маршрутизатор является DR? Какой маршрутизатор является BDR? Каковы критерии отбора?

g.	На R1 выполните команду show ip route ospf, чтобы убедиться, что сеть R2 Loopback1 присутствует в таблице маршрутизации. Обратите внимание, что поведение OSPF по умолчанию заключается в объявлении интерфейса обратной связи в качестве маршрута узла с использованием 32-битной маски.

h.	Запустите Ping до  адреса интерфейса R2 Loopback 1 из R1. Выполнение команды ping должно быть успешным.

Роутер R1

conf t

int lo 1

ip add 172.16.1.1 255.255.255.0

no shutdown

exit

int g0/0/1

ip add 10.53.0.1 255.255.255.0

no shutdown

exit

router ospf 56

router-id 1.1.1.1

int g0/0/1

ip ospf 56 area 0

!

Роутер R2

conf t

int lo 1

ip add 192.168.1.1 255.255.255.0

no shutdown

exit

int g0/0/1

ip add 10.53.0.2 255.255.255.0

no shutdown

exit

router ospf 56

router-id 2.2.2.2

exit

int range g0/0/01, lo1

ip ospf 56 area 0


Убедитесь, что OSPFv2 работает между маршрутизаторами. Выполните команду, чтобы убедиться, что R1 и R2 сформировали смежность.

Вопрос: Какой маршрутизатор является DR? Какой маршрутизатор является BDR? 


![alt text](image-34.png)


![alt text](image-33.png)

Роутер R1 является DR, а R2 BDR

Каковы критерии отбора?

маршрутизаторы выбирают маршрут для передачи данных на основе метрики OSPF cost, но по заданию их не нужно было пока выставлять, еще критериями является пропускная способность порта\интерфейса


g.	На R1 выполните команду show ip route ospf, чтобы убедиться, что сеть R2 Loopback1 присутствует в таблице маршрутизации. Обратите внимание, что поведение OSPF по умолчанию заключается в объявлении интерфейса обратной связи в качестве маршрута узла с использованием 32-битной маски.

h.	Запустите Ping до  адреса интерфейса R2 Loopback 1 из R1. Выполнение команды ping должно быть успешным.

![alt text](image-32.png)

!

**Часть 3. Оптимизация и проверка конфигурации OSPFv2 для одной области**

**Шаг 1. Реализация различных оптимизаций на каждом маршрутизаторе.**

a.	На R1 настройте приоритет OSPF интерфейса G0/0/1 на 50, чтобы убедиться, что R1 является назначенным маршрутизатором.

b.	Настройте таймеры OSPF на G0/0/1 каждого маршрутизатора для таймера приветствия, составляющего 30 секунд.



!
Роутер R1

conf t

int g0/0/1

ip ospf priority 50

ip ospf hell 30

ip ospf dead 60

do copy run start

!

Роутер R2

int g0/0/1

ip ospf hell 30

ip ospf dead 60

do copy run start

c.	На R1 настройте статический маршрут по умолчанию, который использует интерфейс Loopback 1 в качестве интерфейса выхода. Затем распространите маршрут по умолчанию в OSPF. Обратите внимание на сообщение консоли после установки маршрута по умолчанию.

conf t int lo1

ip route 0.0.0.0 0.0.0.0 loopback 1

router ospf 56

default-information originate

!

%Default route without gateway, if not a point-to-point interface, may impact performance



d.	добавьте конфигурацию, необходимую для OSPF для обработки R2 Loopback 1 как сети точка-точка. Это приводит к тому, что OSPF объявляет Loopback 1 использует маску подсети интерфейса.

R2

conf t

int lo1

ip ospf network point-to-point

do copy run start

e.	Только на R2 добавьте конфигурацию, необходимую для предотвращения отправки объявлений OSPF в сеть Loopback 1.

R2

conf t

int lo1

router ospf 56

passive-interface lo1

do copy run start


f.	Измените базовую пропускную способность для маршрутизаторов. После этой настройки перезапустите OSPF с помощью команды clear ip ospf process . Обратите внимание на сообщение консоли после установки новой опорной полосы пропускания.

conf t

router ospf 56

auto-cost reference-bandwidth 1000

предупреждение:

OSPF: Reference bandwidth is changed.
        Please ensure reference bandwidth is consistent across all routers.

!

R1

ctrl+z

enable 

clear ip ospf process 

yes

01:16:31: %OSPF-5-ADJCHG: Process 56, Nbr 2.2.2.2 on GigabitEthernet0/0/1 from FULL to DOWN, Neighbor Down: Adjacency forced to reset

01:16:31: %OSPF-5-ADJCHG: Process 56, Nbr 2.2.2.2 on GigabitEthernet0/0/1 from FULL to DOWN, Neighbor Down: Interface down or detached

01:16:43: %OSPF-5-ADJCHG: Process 56, Nbr 2.2.2.2 on GigabitEthernet0/0/1 from LOADING to FULL, Loading Done

!

R2


01:08:18: %OSPF-5-ADJCHG: Process 56, Nbr 172.16.1.1 on GigabitEthernet0/0/1 from FULL to DOWN, Neighbor Down: Adjacency forced to reset

01:08:18: %OSPF-5-ADJCHG: Process 56, Nbr 172.16.1.1 on GigabitEthernet0/0/1 from FULL to DOWN, Neighbor Down: Interface down or detached

01:08:22: %OSPF-5-ADJCHG: Process 56, Nbr 172.16.1.1 on GigabitEthernet0/0/1 from LOADING to FULL, Loading Done

**Шаг 2. Убедитесь, что оптимизация OSPFv2 реализовалась.**

a.	Выполните команду show ip ospf interface g0/0/1 на R1 и убедитесь, что приоритет интерфейса установлен равным 50, а временные интервалы — Hello 30, Dead 120, а тип сети по умолчанию — Broadcast

![alt text](image-37.png)


b.	На R1 выполните команду show ip route ospf, чтобы убедиться, что сеть R2 Loopback1 присутствует в таблице маршрутизации. Обратите внимание на разницу в метрике между этим выходным и предыдущим выходным. Также обратите внимание, что маска теперь составляет 24 бита, в отличие от 32 битов, ранее объявленных.

![alt text](image-38.png)

c.	Введите команду show ip route ospf на маршрутизаторе R2. Единственная информация о маршруте OSPF должна быть распространяемый по умолчанию маршрут R1.

![alt text](image-39.png)

d.	Запустите Ping до адреса интерфейса R1 Loopback 1 из R2. Выполнение команды ping должно быть успешным.

![alt text](image-40.png)

**Вопрос:**

Почему стоимость OSPF для маршрута по умолчанию отличается от стоимости OSPF в R1 для сети 192.168.1.0/24?

Стоимость OSPF для маршрута по умолчанию  выше для того, чтобы не допустить использования маршрута по умолчанию без необходимости и оптимизировать сетевой трафик и маршрутизацию 


