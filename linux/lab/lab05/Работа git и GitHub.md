# 1. Установить git

apt install git-all

# Проверяем установленную версию

git version

# git version 2.34.1

# Создать репозиторий на github

======================================================

# Создаем каталог для репозиториев

mkdir repo

cd repo

get init

# Initialized empty Git repository in /home/master/repo/.git/ все изменения будут храниться в .git 

# Статус репозитория

git status

# Сперва нужно выставить настройки пользователя

git config --global user.name "sentsov"

git config --global user.email afzf@mail.ru

# Если хотим изменить редактор на удобный нам, то 

git config --global core.editor nano


# Добавление в индекс (в репозиторий), сперва создадим файл и заполним его информацией

touch test

cat>test

hallo!!!!!!

ctrl+c

git add test

# Создаем коммит с коментарием, если ключ -m не ставить, то мы провалимся в редактор чтобы написать комментарий там (хорошим тоном будет писать в комментариях то что мы изменили или для чего был создан файл, который комитится)

git commit -m 'commit test'  

# Просмотр проиндексированных изменений

git diff --cached

# Удаление из индекса 

git rm --cached test

# Не путать в git rm test, это просто удалит наш файл test, если удалим файл с помощью rm test (без git), то можно будет его восстановить командой git restore test

# Смотрим историю комитов

git log

git log --online

# Информация о последнем коммите

git show

# Информация о конкретном коммите

git show [commit_id]

# Вернуть состояние на [commit_id]

git checkout [commit_id]

# Загрузить состояние последнего коммита ветки master (если после возвращения на предыдущий коммит не устроил результат)

git checkout master

# Смотрим, что изменилось

git diff

# Проиндексированные изменения 

git diff --cached

=================================================================



# 2. Создать репозиторий на github



# 3. Добавить ключ для авторизации на github

cd .ssh

ssh-keygen

# Вводим имя ключа 'sentsov_key'  пароль для ключа и подтверждение (например такой же как на у пользователя)

ll

cat sentsov_key.pub

# Копируем содержимое файла и вставляем на сайте github  в настройках профиля в разделе add ssh key

![alt text](image.png)

# В профиле создаем репозиторий Sentsov, после создания заходим в в <>code, выбираем ssh, копируем ссылку и клонируем ее в терминале убунту

# 4. Авторизоваться по ключу на guthub

git clone git@github.com:SentsovAS/sentsov.git

у меня выдает ошибку

git@github.com: Permission denied (publickey).

fatal: Could not read from remote repository.

создал новый ключ ssh без рута, создал новый репозиторий linux_test, 

подгрузил туда ключ

ошибку пишет такую же ((