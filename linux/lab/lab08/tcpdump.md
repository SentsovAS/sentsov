# Базовые навыки работы с tcpdump

# Установка
apt install tcpdump -y

# Список интерфейсов:
tcpdump -D

# Захват всего трафика интерфейса:
tcpdump -i enp0s3

# Запись пакетов в файл
tcpdump -i enp0s3 -w dump.pcap

# Вывод данных в цифровой форме:
tcpdump -nni enp0s3

# Повышенная детализация:
tcpdump -nnvAi enp0s3

# Еще больше деталей
tcpdump -nnvvAi enp0s3

# Только 80 порт:
tcpdump 'tcp port 80' -nnvvAi enp0s3

# Только 3 первых пакета
tcpdump 'tcp port 80' -c 3 -i enp0s3

# Фильтр по хосту и порту
tcpdump 'tcp port 80 and host 192.168.0.88' -i enp0s3

# По порту источника
tcpdump 'tcp src port 80' -nnvi enp0s3

# Фильтр по подсети
tcpdump net 192.168.0.0/24

# ==============ДЗ================

sudo su

apt install tcpdump -y

tcpdump -D

![alt text](image.png)




# 1. Снять дамп сессии работы с сайтом по протоколу HTTP с помощью tcpdump и фильтров

# Запустим tcpdump на 80 порт

tcpdump 'tcp port 80' -nnvvAi enp0s3

# Зайдем на хост в браузере (мо умолчанию 80 порт), получаем следующую запись в лог

![alt text](image-1.png)

# Снимем лог только первых трех пакетов

tcpdump 'tcp port 80' -c 3 -i enp0s3

![alt text](image-2.png)

# Сделаем фильтр по опледеленному хосту (в моем случаи 192.168.106.68)

tcpdump 'tcp port 80 and host 192.168.106.68' -i enp0s3

![alt text](image-3.png)

# 2. сохранить дамп в файл

mkdir dump

cd dump

tcpdump 'tcp port 80 and host 192.168.106.68' -i enp0s3 -w sentsov2_dump.pcap

cat sentsov_dump.pcap

![alt text](image-4.png)

# с повышенной детализацией

tcpdump 'tcp port 80 and host 192.168.106.68' -nnvvAi enp0s3 -w sentsov_dump.pcap

cat sentsov_dump.pcap


# 3. описать процесс установления соединения на основе дампа (провести анализ дампа, показать пакеты для установления TCP-соединения.)

# создадим каталог для общей папки "mount" с виндовой машины и скопируем туда наш дамп

mkdir /home/sentsov/mount

chown sentsov:sentsov /home/sentsov/mount

mount -t vboxsf mount /home/sentsov/mount

cd dump/

cp sentsov_dump.pcap /home/sentsov/mount/

# Устанавливаем Wireshark на виндовой машине, запускаем и открываем файл sentsov_dump.pcap, который был сохранен после сбора следующей команды "tcpdump 'icmp and host 192.168.106.68' -nnvvAi enp0s3"

![alt text](image-5.png)

1. в 0.000000 от хоста 192.168.106.68 хосту 192.168.106.71 по протоколу icmp был отправлен echo запрос
2. в 0.000042 от хоста 192.168.106.71 хосту 192.168.106.68 по протоколу icmp был получен echo ответ

# tcpdump по заданию

tcpdump 'tcp port 80 and host 192.168.106.68' -nnvvAi enp0s3 -w sentsov2_dump.pcap

cp sentsov2_dump.pcap /home/sentsov/mount/

![alt text](image-6.png)

применил в качестве фильтра избранное - (1 пакет)

![alt text](image-7.png)

Это все пакеты для tcp-соединений

на виртуальной машине-линукс ничего не поднято, на виндовой машине зашел на адрес 192.168.106.1 по 80 порту, снял дамп этого действия и скопировал в файл.


