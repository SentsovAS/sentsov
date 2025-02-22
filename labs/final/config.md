
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

int g0/0

ip address 192.168.0.1 255.255.255.0

no shutdown

exit

Clock set 19:31:00 02 feb 2025

# Настройка подинтерфейсов R1


interface g0/1

no shutdown

exit

Interface g0/1.11

Description for vlan 11

Enc dot1Q 11

Ip add 192.168.1.1 255.255.255.0

No shutdown

Exit

Interface g0/1.3

Description for vlan 3

Enc dot1Q 3

Ip add 192.168.3.1 255.255.255.0

ipv6 address FE80::1 link-local

ipv6 address 2001:DB8:ACAD:3::1/64

No shutdown

Exit

Interface g0/1.1000

Description for vlan native

Enc dot1Q 1000 native

No shutdown

exit

# Настройка статического NAT R1

ip nat inside source list 1 interface GigabitEthernet0/2 overload

access-list 1 permit 192.168.1.0 0.0.0.255

int g0/2

ip address 10.53.0.10 255.255.255.0

ip nat outside

exit

int g0/1.11

ip nat inside

exit

show ip nat translations

# Настройка статического маршрута R1

ip route 192.168.2.0 255.255.255.0 GigabitEthernet0/0 

ip route 10.53.1.0 255.255.255.0 GigabitEthernet0/2 

ip route 10.53.5.0 255.255.255.0 GigabitEthernet0/2 

ip route 192.168.2.0 255.255.255.0 GigabitEthernet0/2

# Настройка тунеля до роутера провайдера

# R1

interface Tunnel0

ip address 10.0.0.1 255.255.255.0

tunnel source GigabitEthernet0/2

tunnel destination 10.53.0.1

# R3

interface Tunnel0

ip address 10.0.0.2 255.255.255.0

tunnel source GigabitEthernet0/0

tunnel destination 10.53.0.10

#	Настройка базовых параметров коммутаторов.


# Базовая настройка коммутатора s1

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

login

Exit

Clock set 19:34:00 03 feb 2025

Copy run start


# Базовая настройка коммутатора s3

Enable

Conf t

Hostname s3

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

Exit

Clock set 19:50:00 03 feb 2025

Copy run start


#	Создание сети VLAN на коммутаторах.

# Первый коммутатор S1

Enable 

Conf t

Vlan 11

Name LAN

Vlan 2

Name TV

vlan 3

name VIDEO

Vlan 999

Name ParkingLot

Vlan 1000

Name Native

exit

Interface vlan 11

Ip add 192.168.1.2 255.255.255.0

ip default-gateway 192.168.1.1

Interface range F0/3-24

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface range f0/1-2

switchport mode access

switchport access vlan 11

exit

interface g0/1-2

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 11,2,3,1000

do show interface trunk

# Второй коммутатор S3

Enable 

Conf t

Vlan 11

Name LAN

Vlan 2

Name TV

vlan 3

name VIDEO

Vlan 999

Name ParkingLot

Vlan 1000

Name Native

exit

Interface vlan 3

Ip add 192.168.3.2 255.255.255.0

ip default-gateway 192.168.1.1

interface range f0/1-2,f0/24

switchport mode access

switchport access vlan 3

exit

Interface range f0/3-23, g0/1

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface g0/2

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 11,2,3,1000

do show interface trunk

# Настроим R1 с пулами DHCPv4 для двух поддерживаемых подсетей.

a.	Исключим адреса для статики

b.	Создим пулы DHCP LAN и VIDEO

c.	Укажем сеть, поддерживающую этот DHCP-сервер.

d.	В качестве имени домена укажем PROJECT.com.

e.	Настроим соответствующий шлюз по умолчанию для каждого пула DHCP.

f.	Настроим время аренды на 2 дня 0 часов и 0 минут.


conf t

ip dhcp excluded-address 192.168.1.1 192.168.1.3

ip dhcp excluded-address 192.168.2.1 192.168.2.3

ip dhcp excluded-address 192.168.3.1 192.168.3.3

ip dhcp pool R1_LAN

network 192.168.1.0 255.255.255.0

default-router 192.168.1.1

dns-server 192.168.1.1

domain-name PROJECT.com

lease 2 0 0

exit

ip dhcp pool R1_VIDEO

network 192.168.3.0 255.255.255.0

default-router 192.168.1.1

dns-server 192.168.1.1

domain-name PROJECT.com

lease 2 0 0

exit

ipv6 dhcp pool R1_LAN

address prefix 2001:db8:acad::/64

dns-server 2001:DB8:ACAD:4::1

domain-name LAN.com

interface g0/1.11

ipv6 address 2001:DB8:ACAD:4::1/64

ipv6 address FE80::1 link-local

ipv6 nd other-config-flag 

ipv6 dhcp server R1_LAN


# Настроим DHCP на коммутаторе s1

conf t

ip dhcp excluded-address 192.168.1.1 192.168.1.3

ip dhcp excluded-address 192.168.2.1 192.168.2.3

ip dhcp excluded-address 192.168.3.1 192.168.3.3

ip dhcp pool R1_LAN

network 192.168.1.0 255.255.255.0

default-router 192.168.1.1

dns-server 192.168.1.1

domain-name PROJECT.com

lease 2 0 0

exit

# Настроим DHCP на коммутаторе s3

conf t

ip dhcp excluded-address 192.168.1.1 192.168.1.3

ip dhcp excluded-address 192.168.2.1 192.168.2.3

ip dhcp excluded-address 192.168.3.1 192.168.3.3

ip dhcp pool R1_VIDEO

network 192.168.3.0 255.255.255.0

default-router 192.168.1.1

dns-server 192.168.1.1

domain-name PROJECT.com

lease 2 0 0

exit


# Проверка конфигурации сервера DHCPv4**

show ip dhcp pool 

show ip dhcp binding 



# Базовая настройка маршрутизатора R2

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

int g0/1

no shutdown

int g0/0

ip address 192.168.0.2 255.255.255.0

no shutdown

int g0/1.2

ipv6 add 2001:db8:acad:2::1/64

ipv6 add fe80::1 link-local

Ip add 192.168.2.1 255.255.255.0

Description for vlan 2

Enc dot1Q 2

no shutdown

exit

Interface g0/1.1000

Description for vlan native

Enc dot1Q 1000 native

No shutdown

ipv6 dhcp pool R2_TV

address prefix 2001:db8:acad::/64

dns-server 2001:DB8:ACAD:2::1

interface g0/1.2

ipv6 nd other-config-flag 

ipv6 dhcp server R2_TV

domain-name TV.com

ip dhcp excluded-address 192.168.1.1 192.168.1.3

ip dhcp excluded-address 192.168.2.1 192.168.2.3

ip dhcp excluded-address 192.168.3.1 192.168.3.3

ip dhcp pool R2_TV

network 192.168.2.0 255.255.255.0

default-router 192.168.2.1

dns-server 192.168.2.1

domain-name TV.com

lease 2 0 0

exit

# Настройка статического маршрута R2

ip route 192.168.1.0 255.255.255.0 GigabitEthernet0/0 

ip route 192.168.3.0 255.255.255.0 GigabitEthernet0/0 

ip route 10.53.1.0 255.255.255.0 GigabitEthernet0/2 

ip route 10.53.0.0 255.255.255.0 GigabitEthernet0/2 

ip route 192.168.1.0 255.255.255.0 GigabitEthernet0/2

# Настройка NAT на R2

ip nat inside source list 1 interface GigabitEthernet0/2 overload

access-list 1 permit 192.168.2.0 0.0.0.255

int g0/2

ip address 10.53.5.2 255.255.255.0

ip nat outside

exit

int g0/1.2

ip nat inside

exit

# Базовая настройка коммутатора s2

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

login

Exit

Clock set 19:34:00 03 feb 2025

# Создание сети VLAN на коммутаторе S2.


Enable 

Conf t

Vlan 11

Name LAN

Vlan 2

Name TV

Vlan 3

name VIDEO

Vlan 999

Name ParkingLot

Vlan 1000

Name Native

exit

Interface vlan 2

Ip add 192.168.2.2 255.255.255.0

ip default-gateway 192.168.2.1

Interface range F0/3-24, g0/2

Switchport mode access

Switchport access vlan 999

shutdown

exit

interface range f0/1-2

switchport mode access

switchport access vlan 2

exit

int g0/1

switchport mode trunk

switchport trunk native vlan 1000

switchport trunk allowed vlan 11,2,3,1000


# Настроим DHCP на коммутаторе s2

conf t

ip dhcp excluded-address 192.168.1.1 192.168.1.3

ip dhcp excluded-address 192.168.2.1 192.168.2.3

ip dhcp excluded-address 192.168.3.1 192.168.3.3

ip dhcp pool R2_TV

network 192.168.2.0 255.255.255.0

default-router 192.168.2.1

dns-server 192.168.2.1

domain-name PROJECT.com

lease 2 0 0

exit

# Настройка маршрутизации OSPPF на роутерах интернет провайдера R3, R4, R5, R5

# R3

router ospf 1

network 10.53.1.0 0.0.0.255 area 0

network 10.53.2.0 0.0.0.255 area 0

network 10.53.0.0 0.0.0.255 area 0

interface GigabitEthernet0/0

ip address 10.53.0.1 255.255.255.0

no shutdown

interface GigabitEthernet0/1

ip address 10.53.1.1 255.255.255.0

no shutdown

interface GigabitEthernet0/2

ip address 10.53.2.1 255.255.255.0

no shutdown

ip route 192.168.2.0 255.255.255.0 GigabitEthernet0/1 

ip route 10.53.5.0 255.255.255.0 GigabitEthernet0/1 

ip route 192.168.1.0 255.255.255.0 GigabitEthernet0/0 

ip route 10.53.5.0 255.255.255.0 GigabitEthernet0/2 

ip route 192.168.2.0 255.255.255.0 GigabitEthernet0/2

# R4

router ospf 1

network 10.53.2.0 0.0.0.255 area 0

network 10.53.3.0 0.0.0.255 area 0

interface GigabitEthernet0/1

ip address 10.53.3.1 255.255.255.0

no shutdown

interface GigabitEthernet0/2

ip address 10.53.2.2 255.255.255.0

no shutdown

ip route 192.168.1.0 255.255.255.0 GigabitEthernet0/2 

ip route 192.168.2.0 255.255.255.0 GigabitEthernet0/1 

# R5

router ospf 1

network 10.53.3.0 0.0.0.255 area 0

network 10.53.4.0 0.0.0.255 area 0

interface GigabitEthernet0/1

ip address 10.53.4.2 255.255.255.0

no shutdown

interface GigabitEthernet0/2

ip address 10.53.3.2 255.255.255.0

no shutdown

ip route 192.168.2.0 255.255.255.0 GigabitEthernet0/1 

ip route 192.168.1.0 255.255.255.0 GigabitEthernet0/2

# R6

router ospf 1

network 10.53.1.0 0.0.0.255 area 0

network 10.53.4.0 0.0.0.255 area 0

network 10.53.5.0 0.0.0.255 area 0

interface GigabitEthernet0/0

ip address 10.53.5.1 255.255.255.0

no shutdown

interface GigabitEthernet0/1

ip address 10.53.1.2 255.255.255.0

no shutdown

interface GigabitEthernet0/2

ip address 10.53.4.1 255.255.255.0

no shutdown

ip route 10.53.0.0 255.255.255.0 GigabitEthernet0/1 

ip route 192.168.2.0 255.255.255.0 GigabitEthernet0/0 

ip route 192.168.1.0 255.255.255.0 GigabitEthernet0/1 

ip route 10.53.0.0 255.255.255.0 GigabitEthernet0/2

ip route 192.168.1.0 255.255.255.0 GigabitEthernet0/2 



network 10.53.1.0 0.0.0.255 area 0

network 10.53.2.0 0.0.0.255 area 0

network 10.53.0.0 0.0.0.255 area 0

network 10.53.4.0 0.0.0.255 area 0

network 10.53.5.0 0.0.0.255 area 0

network 192.168.1.0 0.0.0.255 area 0

network 192.168.2.0 0.0.0.255 area 0