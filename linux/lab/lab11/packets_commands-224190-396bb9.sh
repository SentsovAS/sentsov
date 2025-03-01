# Работа с RPM-пакетами
rpm -ivh <file>
yum (dnf) install <package>
yum localinstall <file>
rpm -Uvh <file>
rpm -ev <package>
yum (dnf) remove <package>
yum update
dnf upgrade
yum (dnf) search
rpm -qi <package>
rpm -ql <package>
rpm -qa
yum makecache
yum check-update

# Работа с DEB-пакетами
dpkg -i <file>
apt install <package|file>
dpkg -r <package>
apt remove <package>
apt purge <package>
apt update
apt upgrade
apt -f install
apt autoremove
apt clean
apt list <pattern>
apt-cache showpkg <package>
dpkg -L <package>

# Работа со snap-пакетами
snap search <pattern>
snap install <package>
snap refresh
snap remove



