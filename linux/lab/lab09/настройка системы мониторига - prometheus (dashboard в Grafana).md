# Настроить сервер prometheus, настроить сбор метрик веб-сервера

# Установка полезных утилит мониторинга

apt install -y {jnet,h,io,if,a}top iptraf-ng nmon

# утилита  uptime, обращаем внимание на время работы системы и на нагрузку (средняя длинна очереди исполнения)

uptime

# Память

free -h

# Общая информация с динамическим обновлением 

top

# проверить свободное место на диске

df -h

df -ih (проверка айнодов)

du -hd1

# Определить кто грузит диски можно утилитой iotop

iotop

# Утилита для мониторинга сети

iftop



# 1. установить и настроить prometheus

# Вариант 1
# Качаем по ссылке архив

curl -LO https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz

curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz


# Распаковка архива

tar xzvf prometheus-*.t*gz

tar xzvf node_exporter-*.t*gz

# Создаём папки и копируем файлы

mkdir {/etc/,/var/lib/}prometheus

cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin

cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/

chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/

# Проверка запуска вручную

sudo -u prometheus /usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries

# Установка node_exporter

# Копируем файлы в /usr/local

cp node_exporter-*.linux-amd64/node_exporter /usr/local/bin

chown node_exporter: /usr/local/bin/node_exporter


# Создаём службу node exporter

cat > /etc/systemd/system/node_exporter.service

==============================================================

# Вариант 2

# На убунте можно усановить через команду

sudo apt install prometheus

ss -ntlp

# Видим порты 9090 (веб интерфейс) и 9100 (веб интерфейс) отосящиеся к prometheus и Node Exporter

![alt text](image.png)

![alt text](image-1.png)

![alt text](image-2.png)

# 2. установить агент на web-сервер

# 3. настроить сбор метрик с web-сервера

# 4. настроить графическое отображение метрик в prometheus

# настроим конфиг prometheus

nano /etc/prometheus/prometheus.yml

# чтобы добавить устройства для мониторинга, нужно в разделе job_name: 'node_exporter' добавить свои хосты, например 

- job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100','192.168.106.110:3082']

# Устанавливаем grafana

apt install -y adduser libfontconfig1 musl

wget https://dl.grafana.com/oss/release/grafana_11.4.0_amd64.deb

dpkg -i grafana_11.4.0_amd64.deb

# Автоматически не Запускается, поэтому

systemctl daemon-reload

systemctl start grafana-server

systemctl status grafana-server

# настройка закончена, идем на порт :3000  (порт по умолчанию) (лоин/пароль по умолчанию admin/admin)

![alt text](image-3.png)

# добавляем источник данных prometheus

=>Connections=>Data Sources=> add prometheus=> заполняем Prometheus server URL http://localhost:9090 => save and test

# добавляем dashboards

нажимаем new = > import вбиваем в поле url or id 1860 (это айди нашего node exporter) = > load => выбираем data source prometheus => import

![alt text](image-5.png)





