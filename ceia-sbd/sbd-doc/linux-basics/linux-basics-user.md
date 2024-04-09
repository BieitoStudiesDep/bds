---
tags:
  - linux
  - user
  - group
---

# linux-basics-user

## User and Groups

```bash
su # Cambia al usuario root
su username # Cambia al usuario username


# creamos el usuario mongodb

sudo adduser mongodb

# añadimos usuario mongodb a grupo sudo

sudo usermod -aG sudo mongodb

```

## Permisos

```bash

# r(lectura) w(escritura) x(ejecucion)
# 755 d (7)=rwx (5)=r-x (5)=r-x
# 7 = 4 (lectura) , 2 (escritura) y 1 (ejecución),
# 6 = 4 (lectura) , 2 (escritura)
# 5 = 4 (lectura)  y 1 (ejecución),
# 4 = 4 (lectura)
# 3 =  2 (escritura) y 1 (ejecución).
# 2 =  2 (escritura)
# 1 =  1 (ejecución).
# chown manipular permisos
# -R recursivo (fichero/directorio) actual y losque contiene
chmod +x archivo   # Agrega permiso de ejecución al archivo
chmod -r archivo   # Elimina permisos de lectura al archivo
chmod u+rwx,g+rx,o-rwx archivo   # Establece permisos específicos
chown usuario:grupo archivo   # Cambia el propietario y el grupo del archivo
chgrp grupo archivo   # Cambia el grupo del archivo


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

# verificar
ls -l # lista permisos de ruta actual
ls -l # lista mostrando archivos ocultos

sudo ls -la /home/ | grep "bieito"

sudo ls -la /home/bieito/

sudo ls -la /home/bieito/mongo/bin | grep -E 'mongod|mongos'
```

- usuario `mongodb` lectura , escritura y ejecución : `drwx`.

- grupo `mongodb` lectura y ejecución : `r-x`

- otros lectura y ejecución : `r-x`

```bash

drwxr-xr-x 2 mongodb mongodb 4096 feb 24 04:49 log

drwxr-xr-x 3 mongodb mongodb 4096 feb 24 05:29 mongo

drwx------ 3 bieito bieito 4096 feb 27 00:30 .mongodb

drwxr-xr-x 2 mongodb mongodb 4096 feb 27 00:34 mongo-download

drwxr-xr-x 3 mongodb mongodb 4096 feb 19 11:00 mongosh

drwxr-xr-x 3 mongodb mongodb 4096 feb 27 00:32 mongo-tools

```
