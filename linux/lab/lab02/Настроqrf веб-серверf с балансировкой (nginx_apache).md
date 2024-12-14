**Настройка веб-сервера с балансировкой (nginx_apache)**


!

apt install nginx

#Запуск Nginx

systemctl start nginx

#Проверка статуса

systemctl status nginx

**установить nginx и apache**

!

apt install apache2

#Запуск Apache

systemctl start apache2

#Автозапуск Apache

systemctl enable apache2

#Проверка статуса

systemctl status apache2

**настроить работу apache на порты отличные от порта 80**

cd /etc/apache2

ll

nano ports.conf

меняем порт 80 на 8081

Listen 80 => Listen 8081

остальное комментируем #

ctrl+o

ctrl+x

![image](https://github.com/user-attachments/assets/a98115d2-5034-43a0-bf87-13de3dee9776)



далее нужно поменять так же порт в файле конфигурации сайтов


cd sites-enabled/  #   путь /etc/apache2/sites-enabled/

ll

#открываем конфигурационный файла сайтов и меняем виртуальный порт на 8081

nano 000-default.conf   

<VirtualHost *:80> на <VirtualHost *:8081> 

#* означает что порт для всех хостов


#проверка загрузки url

curl localhost:8081 | grep 8081

**настройть работу nginx на порт 80**

cd /etc/nginx

ll

cd sites-enabled/

ll

nano default

 по умолчанию в конфиге установлен порт 80, ничего не меняем кроме ссылки на файл отображения при обращении к странице

root /usr/share/nginx/html;

**настроить upstrean в nginx для BackEnd apache**

для начала создадим копию файла html, чтобы обращение по определенному порту выдовало разные результаты

cd /var/www/

cp -r html htmp2

редактируем каждый из файлов, меняем, например, верисию в заголовке приветствия, чтобы мы понимали чем они отличаются

nano index.html1

< h1> welcome to nginx! version 2 < /h1>

nano index.html2

< h1> welcome to nginx! version 3 < /h1>

cd /etc/apache2/sites-available

ll

# Вариант №1

#копируем\размножаем файл конфига 000-default.conf 

cp 000-default.conf 002.conf

cp 000-default.conf 003.conf

#делаем символическую ссылку для каждого

ln -s 002.conf ../sites-enabled/002

ln -s 003.conf ../sites-enabled/003

cd /etc/apache2/sites-enabled/

000-defaul.conf у нас уже настроен

настроим два других конфига

nano 002.conf

</VirtualHost>

####################################################

Listen 8081

<VirtualHost *:8081>

	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html1

	ErrorLog /var/log/httpd/error1.log
	CustomLog /var/log/httpd/access1.log combined


ctrl+x

yes+enter

nano 003.conf

</VirtualHost>

####################################################

Listen 8082

<VirtualHost *:8082>

	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html2

	ErrorLog /var/log/httpd/error2.log
	CustomLog /var/log/httpd/access2.log combined

ctrl+x

yes+enter

apachectl -t  # проверка конфига на наличие ошибок

systemctl reload apache2  # перегружаем апач чтобы настроику изменения конфига вступили в силу

# Вариант №2

не размножаем файл конфига, прописываем все в 000-default.conf

##################################################

<VirtualHost *:8080>

	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html

	ErrorLog /var/log/httpd/error.log
	CustomLog /var/log/httpd/access.log combined

</VirtualHost>

####################################################

Listen 8081

<VirtualHost *:8081>

	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html1

	ErrorLog /var/log/httpd/error1.log
	CustomLog /var/log/httpd/access1.log combined

</VirtualHost>

####################################################

Listen 8082

<VirtualHost *:8082>

	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html2

	ErrorLog /var/log/httpd/error2.log
	CustomLog /var/log/httpd/access2.log combined

</VirtualHost>

**настроить перенаправление обращения nginx на upstream.**

**в nginx для сайта на порту 80 прописан proxy_pass на upstream**

cd /etc/nginx/sites-enabled/

nano default

#меняем конфиг в соответствии с заданием

upstream backend {
    
	server 127.0.0.1:8080 weight=2;
	server 127.0.0.1:8081;
	server 127.0.0.1:8082;
}

server {
        listen       80;

        listen       [::]:80;

        server_name  _;

        root         /usr/share/nginx/html;


        include /etc/nginx/default.d/*.conf;

		location / {
			#try_files $uri $uri/ =404;
            #меняем proxy_pass http://localhost:8080; на proxy_pass http://backend;
			proxy_pass http://backend;  
			proxy_set_header Host $host;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_set_header X-Real-IP $remote_addr;
		}

		location ~ \.php$ {
			include fastcgi_params;
			root /var/www/html;
			fastcgi_pass unix:/run/php/php7.4-fpm.sock;
			#fastcgi_pass 127.0.0.1:9000;
		}

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
}


![image](https://github.com/user-attachments/assets/715bdea7-d86a-412c-aa2b-60b0b4ceeb02)


