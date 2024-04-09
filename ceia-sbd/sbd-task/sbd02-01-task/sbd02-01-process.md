<!-- cSpell:ignore netplan,bieitoserver,tunombreserver,autoarrancarlos
-->

# sbd02-01-process

![sbd02-01-link](sbd02-01-link.md)

## Instalación MongoDb

### practica guiada

```bash
# creamos el usuario mongodb
sudo adduser mongodb
# añadimos usuario mongodb a grupo sudo
sudo usermod -aG sudo mongodb
# cambiamos al usuario mongodb
su mongodb
# nos situamos en su carpeta home
cd /home/mongodb
# buscamos en la web el ejecutable para instalar mongoDb y nos lo traemos
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2204-7.0.4.tgz
# lo descomprimimos
tar -zxvf mongodb-linux-x86_64-ubuntu2204-7.0.4.tgz
# lo movemos a la ubicación deseada
mv mongodb-linux-x86_64-ubuntu2204-7.0.4 mongo
#
ls /home/mongodb/mongo/bin
# binario encargado de la parte servidora [mongod]
mongod
# binario encargado de la interfaz de comandos [mongos]
mongos
# añadimos los binarios al PATH lo hacemos directamente en el shell de bash indicando que en el entorno de dicho shell actualizaremos la variable PATH con los binarios
# editamos sudo nano /home/mongodb/.bashrc
# añadiendo export PATH=$PATH:/home/mongodb/mongo/bin
sudo sh -c 'echo "export PATH=$PATH:/home/mongodb/mongo/bin">> /home/mongodb/.bashrc'
sudo sh -c 'echo "PATH=$PATH:/home/mongodb/mongo/bin" >> /etc/environment'
# verificar
echo $PATH
# definimos la carpeta de los log
mkdir /home/mongodb/log
# definimos la carpeta de los datos
sudo mkdir /opt/datos
sudo chown -R mongodb:mongodb /opt/datos
# verificar que el usuario mongodb puede escribir en la carpeta (&) en segundo plano
mongod –dbpath=/opt/datos &
# creamos una archivo de configuración
sudo nano /etc/mongod.conf
########################
# Network interfaces.
net:
  port: 27017
  bindIp: 127.0.0.1
# Ruta de almacenamiento de datos
storage:
   dbPath: /opt/datos

# Ruta de registro de logs
systemLog:
   destination: file
   path: "/home/mongodb/log/mongo.log"
   logAppend: true

########################
# iniciamos mongo con la configuración definida (&) en segundo plano
mongod --config /etc/mongodb.conf &
# para evitar esta practica de lanzar manualmente mongo , creamos un servicio
sudo nano /etc/systemd/system/mongod.service
########################
[Unit]
Description=MongoDB Database Server
Documentation=https://docs.mongodb.org/manual
After=network-online.target
Wants=network-online.target

[Service]
type=simple
User=mongodb
Group=mongodb
WorkingDirectory=home/mongodb/mongo/bin
Environment="OPTIONS=--config /etc/mongod.conf"
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
######################
# iniciar servicio
sudo systemctl start mongod.service
# modificadores de un servicio [start, stop, restart, mask, unmask, status, enable y disable]
# ver el estado del servicio
sudo systemctl status mongod.service
# aviltar servicio
sudo systemctl enable mongod.service
```

### tarea

#### creamos los ficheros

```bash
mkdir /home/bieito/datos
mkdir /home/bieito/log/
touch /home/bieito/log/mongo.log
```

#### creamos el usuario [mongodb]

```bash
# creamos el usuario mongodb
sudo adduser mongodb
# añadimos usuario mongodb a grupo sudo
sudo usermod -aG sudo mongodb
```

#### instalamos

```bash
# buscamos en la web el ejecutable para instalar mongoDb y nos lo traemos
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2204-7.0.4.tgz
# lo descomprimimos
tar -zxvf mongodb-linux-x86_64-ubuntu2204-7.0.4.tgz
# lo movemos a la ubicación deseada
mv mongodb-linux-x86_64-ubuntu2204-7.0.4 /home/bieito/mongo
#
```

#### actualizamos entorno

```bash
sudo sh -c 'echo "PATH=$PATH:/home/bieito/mongo/bin" >> /etc/environment'
```

#### damos los permisos adecuados al usuario mongodb sobre `home/bieito/mongo`, `/home/bieito/log`,`/home/bieito/datos`

tengo dos usuarios , uno bieito y otro mongodb, defino los siguientes directorios:
`home/bieito/mongo` : donde guardo los archivos de instalación y los binarios de mongodb
`/home/bieito/log` : donde guardo los logs que genere mongodb
`/home/bieito/datos` : donde almaceno los datos de mongodb
que permisos tendría las carpetas citadas para que puedan trabajar con mongodb los dos usuarios

```bash
# permisos para el usuario mongodb
sudo chown -R mongodb:mongodb /home/bieito/mongo;
sudo chown -R mongodb:mongodb /home/bieito/log;
sudo chown -R mongodb:mongodb /home/bieito/datos;
sudo chown -R mongodb:mongodb /home/bieito/mongo-tools;
sudo chown -R mongodb:mongodb /home/bieito/mongo-download;
sudo chown -R mongodb:mongodb /home/bieito/.mongodb;
# permisos adecuados en los directorios para ambos usuarios:
sudo chmod -R 755 /home/bieito/ #otros puedan ler y ejecutar
sudo chmod -R 755 /home/bieito/mongo;
sudo chmod -R 755 /home/bieito/log;
sudo chmod -R 755 /home/bieito/datos;
sudo chmod -R 755 /home/bieito/mongo-tools;
sudo chmod -R 755 /home/bieito/mongo-download;
sudo chmod -R 755 /home/bieito/.mongodb;
```

> Con estos comandos, estás estableciendo que el propietario y el grupo de cada directorio sean bieito para los directorios /home/bieito/mongo, /home/bieito/log y /home/bieito/datos, y mongodb para el usuario mongodb. Además, se están asignando permisos de lectura, escritura y ejecución para el propietario (rwx), y permisos de lectura y ejecución para el grupo y otros (r-x). Esto permitirá que ambos usuarios accedan y trabajen con los directorios de manera adecuada.

#### creamos los ficheros de configuración

##### 📄 /etc/mongod.conf

```bash
# creamos una archivo de configuración
sudo nano /etc/mongod.conf
########################
# Network interfaces.
net:
  port: 27017
  bindIp: 0.0.0.0
# Ruta de almacenamiento de datos
storage:
   dbPath: /home/bieito/datos

# Ruta de registro de logs
systemLog:
   destination: file
   path: "/home/bieito/log/mongo.log"
   logAppend: true
########################
```

##### 📄 etc/systemd/system/mongod.service

```bash
sudo nano /etc/systemd/system/mongod.service
########################
Description=MongoDB Database Server
Documentation=https://docs.mongodb.org/manual
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=mongodb
Group=mongodb
WorkingDirectory=/home/bieito/mongo/bin
Environment="OPTIONS=--config /etc/mongod.conf"
ExecStart=/home/bieito/mongo/bin/mongod $OPTIONS

[Install]
WantedBy=multi-user.target
######################
```

#### levantar el servicio

```bash
# verificar configuración
mongod --config /etc/mongod.conf &
# iniciar servicio
sudo systemctl start mongod.service
# modificadores de un servicio [start, stop, restart, mask, unmask, status, enable y disable]
# ver el estado del servicio
sudo systemctl status mongod.service
#  servicio
sudo systemctl start mongod.service # iniciar
sudo systemctl status mongod.service # ver estado
sudo systemctl enable mongod.service # persistencia , iniciar al inicio del sistema

sudo systemctl daemon-reload
sudo systemctl restart mongod
sudo systemctl status mongod
```

verificar

```bash
#!/bin/bash
# sudo chown -R mongodb:mongodb /home/bieito/mongo-conf-verif/
# sudo chmod -R 755 /home/bieito/mongo-conf-verif/
# touch /home/bieito/mongo-conf-verif/verif-mongodb.log;
# touch /home/bieito/mongo-conf-verif/script_verif_mongodb.sh;
# chmod +x /home/bieito/mongo-conf-verif/script_verif_mongodb.sh;
# nano /home/bieito/mongo-conf-verif/script_verif_mongodb.sh;

{
echo ""
echo "- [servicio] -  /etc/systemd/system/mongod.service           -"
echo "----------------------------------------------------"
sudo cat /etc/systemd/system/mongod.service;
echo ""
echo "- [mongo conf] -  /etc/mongod.conf           -"
echo "----------------------------------------------------"
sudo cat /etc/mongod.conf;
echo ""
echo "- [mongo env] -  /home/mongodb/.bashrc          -"
echo "----------------------------------------------------"
sudo cat /home/mongodb/.bashrc | grep mongo/bin;
echo "----------------------------------------------------"
echo ""
echo "- [permisos log] -  /home/mongodb/.bashrc          -"
ls -la /home/bieito/log;
echo ""
echo "- [permisos datos] -  /home/mongodb/.bashrc          -"
echo "----------------------------------------------------"
ls -la /home/bieito/datos;
echo ""
echo "- [permisos mongo] -  /home/mongodb/.bashrc          -"
echo "----------------------------------------------------"
ls -la /home/bieito/mongo;
echo "----------------------------------------------------"
ls -la /home/bieito/mongo/bin;
} > /home/bieito/mongo-conf-verif/verif-mongodb.log

```

---

### ejecución

```bash
sh /home/bieito/mongo-conf-verif/script_verif_mongodb.sh;
cat /home/bieito/mongo-conf-verif/verif-mongodb.log;
```

### salida

```bash
 sh /home/bieito/mongo-conf-verif/script_verif_mongodb.sh;
cat /home/bieito/mongo-conf-verif/verif-mongodb.log;

- [servicio] -  /etc/systemd/system/mongod.service           -
----------------------------------------------------
Description=MongoDB Database Server
Documentation=https://docs.mongodb.org/manual
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=mongodb
Group=mongodb
WorkingDirectory=/home/bieito/mongo/bin
Environment="OPTIONS=--config /etc/mongod.conf"
ExecStart=/home/bieito/mongo/bin/mongod $OPTIONS

[Install]
WantedBy=multi-user.target

- [mongo conf] -  /etc/mongod.conf           -
----------------------------------------------------
# Network interfaces.
net:
  port: 27017
  bindIp: 0.0.0.0
# Ruta de almacenamiento de datos
storage:
   dbPath: /home/bieito/datos

# Ruta de registro de logs
systemLog:
   destination: file
   path: "/home/bieito/log/mongo.log"
   logAppend: true

- [mongo env] -  /home/mongodb/.bashrc          -
----------------------------------------------------
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/home/bieito/mongo/bin:/home/bieito/mongosh/bin:/home/bieito/mongo-tools/bin/
----------------------------------------------------

- [permisos log] -  /home/mongodb/.bashrc          -
total 232
drwxr-xr-x  2 mongodb mongodb   4096 feb 24 04:49 .
drwxr-xr-x 14 bieito  bieito    4096 mar  4 10:34 ..
-rwxr-xr-x  1 mongodb mongodb 223874 mar  4 10:29 mongo.log

- [permisos datos] -  /home/mongodb/.bashrc          -
----------------------------------------------------
total 388
drwxr-xr-x  4 mongodb mongodb  4096 mar  4 10:39 .
drwxr-xr-x 14 bieito  bieito   4096 mar  4 10:34 ..
-rwxr-xr-x  1 mongodb mongodb 20480 mar  4 10:29 collection-0-5827922988237080442.wt
-rwxr-xr-x  1 mongodb mongodb 36864 mar  4 10:30 collection-2-5827922988237080442.wt
-rwxr-xr-x  1 mongodb mongodb 36864 feb 27 01:02 collection-4-5827922988237080442.wt
drwxr-xr-x  2 mongodb mongodb  4096 mar  4 10:39 diagnostic.data
-rwxr-xr-x  1 mongodb mongodb 20480 mar  4 10:29 index-1-5827922988237080442.wt
-rwxr-xr-x  1 mongodb mongodb 36864 mar  4 10:30 index-3-5827922988237080442.wt
-rwxr-xr-x  1 mongodb mongodb 36864 feb 27 01:02 index-5-5827922988237080442.wt
-rwxr-xr-x  1 mongodb mongodb 36864 mar  4 10:30 index-6-5827922988237080442.wt
drwxr-xr-x  2 mongodb mongodb  4096 mar  4 10:30 journal
-rwxr-xr-x  1 mongodb mongodb 20480 mar  4 10:29 _mdb_catalog.wt
-rwxr-xr-x  1 mongodb mongodb     4 mar  4 10:29 mongod.lock
-rwxr-xr-x  1 mongodb mongodb 36864 mar  4 10:30 sizeStorer.wt
-rwxr-xr-x  1 mongodb mongodb   114 feb 24 21:43 storage.bson
-rwxr-xr-x  1 mongodb mongodb    50 feb 24 21:43 WiredTiger
-rwxr-xr-x  1 mongodb mongodb  4096 mar  4 10:29 WiredTigerHS.wt
-rwxr-xr-x  1 mongodb mongodb    21 feb 24 21:43 WiredTiger.lock
-rw-------  1 mongodb mongodb  1479 mar  4 10:39 WiredTiger.turtle
-rwxr-xr-x  1 mongodb mongodb 69632 mar  4 10:39 WiredTiger.wt

- [permisos mongo] -  /home/mongodb/.bashrc          -
----------------------------------------------------
total 188
drwxr-xr-x  3 mongodb mongodb   4096 feb 24 05:29 .
drwxr-xr-x 14 bieito  bieito    4096 mar  4 10:34 ..
drwxr-xr-x  2 mongodb mongodb   4096 feb 24 05:29 bin
-rwxr-xr-x  1 mongodb mongodb  30608 nov 15 21:12 LICENSE-Community.txt
-rwxr-xr-x  1 mongodb mongodb  16726 nov 15 21:12 MPL-2
-rwxr-xr-x  1 mongodb mongodb   1978 nov 15 21:12 README
-rwxr-xr-x  1 mongodb mongodb 122506 nov 15 21:12 THIRD-PARTY-NOTICES
----------------------------------------------------
total 304124
drwxr-xr-x 2 mongodb mongodb      4096 feb 24 05:29 .
drwxr-xr-x 3 mongodb mongodb      4096 feb 24 05:29 ..
-rwxr-xr-x 1 mongodb mongodb     15141 nov 15 21:12 install_compass
-rwxr-xr-x 1 mongodb mongodb 181872200 nov 15 22:38 mongod
-rwxr-xr-x 1 mongodb mongodb 129520840 nov 15 22:37 mongos
```

```bash
sudo apt install mongodb-clients
sudo apt-get install mongodb-clients

export PATH=/usr/bin/mongo:$PATH

# conexión local
mongo "mongodb://localhost:27017"

# conexión - cliente externo
mongo "mongodb://mongodb@192.168.0.50:27017"
```
