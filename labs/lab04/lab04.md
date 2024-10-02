
**Лабораточная работа. Настройка IPv6-адресов на сетевых устройствах**


!

![image](https://github.com/user-attachments/assets/c491ad36-ae91-4972-abbe-9de73f8de0d2)


!

**Часть 1. Настройка топологии и конфигурация основных параметров маршрутизатора и коммутатора**

!

**Шаг 1. Настройте маршрутизатор.**

!
hostname R1

ip cef

ipv6 unicast-roting

no ipv6 cef

!

![image](https://github.com/user-attachments/assets/49b19e14-8514-49fc-8ec7-06993a025eec)


!
 

**Шаг 2. Настройте коммутатор.**
!


hostname S1

![image](https://github.com/user-attachments/assets/ffac502a-181f-43af-9d9b-040a33b9b295)


!

**Часть 2. Ручная настройка IPv6-адресов**

!

**Шаг 1. Назначьте IPv6-адреса интерфейсам Ethernet на R1.**

!

**a.	Назначьте глобальные индивидуальные IPv6-адреса, указанные в таблице адресации обоим интерфейсам Ethernet на R1.**

**b.	Введите команду show ipv6 interface brief, чтобы проверить, назначен ли каждому интерфейсу корректный индивидуальный IPv6-адрес.**

**c.	Чтобы обеспечить соответствие локальных адресов канала индивидуальному адресу, вручную введите локальные адреса канала на каждом интерфейсе Ethernet на R1.**

**d.	Используйте выбранную команду, чтобы убедиться, что локальный адрес связи изменен на fe80::1.**

enable

conf t

int gig 0/0/0

ipv6 address 2001:db8:acad:a::1/64

ipv6 address fe80::1 link-local

exit

int g 0/0/1

ipv6 enable 

ipv6 address 2001:db8:acad:1::1/64

ipv6 address fe80::1 link-local

exit

int range g 0/0/0-1

no shutdown

ctrl+z

copy run start

show ipv6 interface br

!

![image](https://github.com/user-attachments/assets/7e2710d1-9097-47e1-9812-f474c7b4f9c3)


!

**Какие группы многоадресной рассылки назначены интерфейсу G0/0?**

show int g 0/0/0

!

FF02::2

!


**Шаг 2. Активируйте IPv6-маршрутизацию на R1.**

!

**a.	В командной строке на PC-B введите команду ipconfig, чтобы получить данные IPv6-адреса, назначенного интерфейсу ПК.**

!

![image](https://github.com/user-attachments/assets/b7c588ad-0036-4f5c-941c-07194798fbe9)


!



**Назначен ли индивидуальный IPv6-адрес сетевой интерфейсной карте (NIC) на PC-B?**

!
нет

!

**b.	Активируйте IPv6-маршрутизацию на R1 с помощью команды IPv6 unicast-routing.**

!

enable

conf t

ipv6 unicast-routing

!

**c.	Теперь, когда R1 входит в группу многоадресной рассылки всех маршрутизаторов, еще раз введите команду ipconfig на PC-B. Проверьте данные IPv6-адреса.
Вопрос:
Почему PC-B получил глобальный префикс маршрутизации и идентификатор подсети, которые вы настроили на R1?**

На R1 все интерфейсы IPv6 теперь являются частью многоадресной группы FF02::2

!


**Шаг 3. Назначьте IPv6-адреса интерфейсу управления (SVI) на S1.**

!

**a.	Назначьте адрес IPv6 для S1. Также назначьте этому интерфейсу локальный адрес канала fe80::b.**



**b.	Проверьте правильность назначения IPv6-адресов интерфейсу управления с помощью команды show ipv6 interface vlan1.**

!

enable

conf t

sdm prefer dual-ipv4-and-ipv6 default

end

reload

enable

conf t

interface vlan 1

ipv6 address 2001:db8:acad:1::b/64

ipv6 address fe80::b link-local

no shutdown

ctrl+z

enable

copy run start

show ipv6 interface vlan1

![image](https://github.com/user-attachments/assets/a52cc094-f599-4ce4-a1ad-42fc7131aa2b)


!

**Шаг 4. Назначьте компьютерам статические IPv6-адреса.**

!

**a.	Откройте окно Свойства Ethernet для каждого ПК и назначьте адресацию IPv6.**

!
**b.	Убедитесь, что оба компьютера имеют правильную информацию адреса IPv6. Каждый компьютер должен иметь два глобальных адреса IPv6: один статический и один SLACC.
Примечание. При выполнении работы в среде Cisco Packet Tracer установите статический и SLAAC адреса на компьютеры последовательно, отразив результаты в отчете**

!

![image](https://github.com/user-attachments/assets/60a7227f-4493-45e9-95de-4a2bdf072c8c)

!

![image](https://github.com/user-attachments/assets/5fadcd50-e1b6-43f2-a427-fca3a0cb48d5)


!

![image](https://github.com/user-attachments/assets/42e0dc03-6fba-468b-bdd9-4235e33f1045)

!

![image](https://github.com/user-attachments/assets/9fc4ed25-6ac5-4d31-9480-5083961eb1b9)



!
**Часть 3. Проверка сквозного подключения**

!

**С PC-A отправьте эхо-запрос на FE80::1. Это локальный адрес канала, назначенный G0/1 на R1.**

!

![image](https://github.com/user-attachments/assets/f608aff6-7f43-4bc5-8d92-8b66b5bd6d7b)


!

**Отправьте эхо-запрос на интерфейс управления S1 с PC-A.**

!

![image](https://github.com/user-attachments/assets/9bed2ca9-f683-459d-a9fd-3ac64d692b5c)


!

**Введите команду tracert на PC-A, чтобы проверить наличие сквозного подключения к PC-B.**

!

![image](https://github.com/user-attachments/assets/736c52de-e3d7-410a-937a-57af2792bda3)


!

**С PC-B отправьте эхо-запрос на PC-A.**

!

![image](https://github.com/user-attachments/assets/3df68d6f-5908-4732-a36a-7e0a4a0b4f62)


!

**С PC-B отправьте эхо-запрос на локальный адрес канала G0/0 на R1.**

!

![image](https://github.com/user-attachments/assets/d1df511d-3d4c-4516-a9b9-36541ee33974)


!
**1.	Почему обоим интерфейсам Ethernet на R1 можно назначить один и тот же локальный адрес канала — FE80::1**
!

пакеты с адресом link-local никогда не покидают локальную сеть в которой назначены.
!

**2.	Какой идентификатор подсети в индивидуальном IPv6-адресе 2001:db8:acad::aaaa:1234/64?**

ноль
