# NetworkManager

# посмотреть интерфейсы
nmcli

# установить IP-адрес для устройства eth0
nmcli device modify eth0 ipv4.address 192.168.0.71/24

# установить адрес шлюза для устройства eth0
nmcli device modify eth0 ipv4.gateway 192.168.0.254

# установить адрес DNS для устройства eth0
nmcli device modify eth0 ipv4.dns 192.168.0.254

# проверить настройки устройства eth0
nmcli device show eth0

# networking

# Отключаем NetworkManager для исключения конфликтов
sudo systemctl --now mask NetworkManager
sudo apt remove network-manager-gnome

sudo ifquery eth0
sudo ifdown eth0; sudo ifup eth0
man interfaces

# systemd-newtworkd
sudo systemctl --now mask NetworkManager
sudo systemctl --now mask networking
sudo systemctl --now mask resolvconf
sudo systemctl unmask systemd-networkd
sudo systemctl enable --now systemd-networkd
sudo systemctl unmask systemd-resolved
sudo systemctl enable --now systemd-resolved

# Конфигурация /etc/systemd/network или /run/systemd/network

man systemd-networkd
man systemd.link
man systemd.network
man systemd.netdev
man systemd-resolved

# Управление resolvectl
# Текущая конфигурация
resolvectl status
# Настройки по интерфейсам
resolvectl dns
# Сборос кэша
resolvectl flush-caches
man resolvectl

# Netplan
# Тестировать настройки
sudo netplan try
# Применить настройки
sudo netplan apply
# Создать конфиги
sudo netplan generate





