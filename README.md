# alex-k812_infra
alex-k812 Infra repository

#Homework 2.1
##Ansible lab N1
1. Создано лабораторое окружение для выполнения задания.
1. Выполнены шаги согласно практическому занятию. После деплоя приложения вручную, созданный пэйбук не внесет никаких изменений, но после удаления клонированного репозитория выполнение плэйбука отбразит его успешное выполнение.
Задание с *
1. Изучена документация о dynamic inventory.
1. Создан файл inventory.json
1. Для успешного выполнения команды 'ansible all -m ping' создан my.gcp.yml для получения ip адресов и формирования групп инстансов.
1. В конфиг файл добавлен параметр inventory сслыающийся на my.gcp.yml для работы в формате json.
1. Отличие статического от динамического инвентори заключается в его получении и использовании, если в статическом мы описываем только конкретные параметры, в динамическом мы можем выборочно работать со всеми динамическими параметрами хоста.

#Homework 7
## Terraform lab N2

1. Структура проекта изменена согласно заданию с разделением на Stage и Prod и выносом созания ВМ и правила файрвола в модули.
1. Созданы соответствующие шаблоны для Пакера.
1. Испольован модуль storage-bucket для хранения state конфигурации в "облаке", конфигурация хранится в файле backend.tf.
1. Созана переменная среды DATABASE_URL.
1. Реализовать отключение провижионеров можно через ресурс null_resource.

# Homework 6
## Terraform lab N1

1. Согласно заданию созданы бранч и конфигурационные файлы для Терраформ.
1. Так как существует ранее созданый черед веб-консоль ssh ключ в метаданных, проблем с подключением не было.
1. Задана значения переменных согласно заданию.
1. В код добавлено создание ssh ключей для пользователей, количество которых задается в переменной sshuser.
1. Если добавлять ssh ключи вручную через веб-консоль, терраформ перезапишет их согласно конфигурации.
1. Задание *: Создана конфигурация балансировщика в lb.tf с использованием ресурсов instance_group, global_address, target_http_proxy, global_forwarding_rule, url_map, backend_servic и health_check.
1. Задание **: Так как повторение в коде создания однинаковых ресурсов нецелесообразно, используется переменная count.

# Homework 5
## Create GCP image with Packer.
1. Создан шаблон Пакера ubuntu16.json для образа reddit-base
1. Создан шаблон immutable.json для образа reddit-full
1. Создан файл с переменными для сборки образов.
1. Добавлены скрипты для установки образ Ruby, Mongodb, Puma и создания сервиса puma.service с помощью systemd.
1. Создан скрипт для сборки готовой ВМ reddit-app  из образа reddit-full:
gcloud compute --project=infra-253316 instances create reddit-app \
--image-family=reddit-full \
--image-project=infra-253316 \
--zone=europe-west3-c \
--machine-type=f1-micro \
--tags puma-server \
--restart-on-failure


# Homework 4
## Create Instance, FW Rule and deploy app
1. Развернута ВМ, на ней развернуты Ruby, MongoDB, поднят Puma сервер.
1. Созданы скрипты: install_ruby.sh для установки Ruby, install_mongodb.sh для MongoDB, deploy.sh для развертывания приложения на web-сервере Puma.
1. Создан общий скрипт startup_script.sh для автоматизации процесса присоздании ВМ на GCP.
1. Создан скрипт gcloud.sh для автоматического развертывания инстанса ВМ и приложения на ней.
1. Для использвания стартап скрипта создан бакет 
```
sudo gsutil mb -l europe-west3 gs://akotus-stuff
```
и скопирован в него
```
sudo gsutil cp /home/ak/GitHub/alex-k812_infra/startup_script.sh gs://akotus-stuff.
```

Команды, использованные для создания инстанса:
```
gcloud compute instances create reddit-app --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --metadata startup-script=gs://akotus-stuff/startup_script.sh
```
Для создания правила FW:
```
gcloud compute firewall-rules create default-puma-server \
--allow tcp:9292 \
--direction INGRESS \
--source-ranges="0.0.0.0/0" \
--target-tags puma-server
```
Данные для проверки ДЗ:
testapp_IP = 35.246.181.90
testapp_port = 9292


# Homework 3
## GCP. VPN.
1. Для подключения к ВМ2 в локальной сети за ВМ1 с внешним ip по ssh нужно выполнить следующую команду: ssh -t -i ~/.ssh/ak -A ak@35.207.109.237 ssh 10.156.0.4
1. Для подключения через алиас, в моем случае:ssh inst1, к ВМ2 следует создать ssh конфиг следующего вида:

```
host inst1
    HostName 10.156.0.4
    Port 22
    IdentityFile ~/.ssh/ak
    ProxyCommand ssh ak@bastion -W %h:%p
```
```
host bastion
    HostName 35.207.109.237
    Port 22
    IdentityFile ~/.ssh/akroot@ak-otus:~/.ssh#
```
Развертывание ВПН сервера осуществляется через setupvpn.sh. На сервере создан пользователь test с указанным в задании ПИН-ом, конфигурация для пользователя содержится в файле cloud-bastion.ovpn.
Данные для подключения:
```
bastion_IP = 35.207.109.237

someinternalhost_IP = 10.156.0.6
```
