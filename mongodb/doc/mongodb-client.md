<!-- cSpell:ignore mongosh -->
<!-- markdownlint-disable MD041 -->

## mongo-client

### mongo-client instalar clientes binarios

#### install MongoDB Shell Download [mongosh]

```bash
wget https://downloads.mongodb.com/compass/mongosh-2.1.5-linux-x64.tgz
# lo descomprimimos
tar -zxvf mongosh-2.1.5-linux-x64.tgz
# lo movemos a la ubicación deseada
mv mongosh-2.1.5-linux-x64 mongosh
# añadimos para el usuario mongodb
# en su sell el la ruta del binario
sudo nano /home/mongodb/.bashrc
# añadimos ultima la linea / actualizamos ultima linea
export PATH="$PATH:/home/bieito/mongo/bin:/home/bieito/mongosh/bin"
su mongodb
source /home/mongodb/.bashrc
```

#### install MongoDB Command Line Database Tools Download

[bsondump mongodump mongoexport mongofiles mongoimport mongorestore mongostat mongotop]

```bash
wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.9.4.tgz
# lo descomprimimos
tar -zxvf mongodb-database-tools-ubuntu2204-x86_64-100.9.4.tgz
# lo movemos a la ubicación deseada
mv mongodb-database-tools-ubuntu2204-x86_64-100.9.4 mongo-tools
# añadimos para el usuario mongodb
# en su sell el la ruta del binario
sudo nano /home/mongodb/.bashrc
# añadimos la linea
export PATH=$PATH:/home/bieito/mongo/bin:/home/bieito/mongosh/bin:/home/bieito/mongo-tools/bin/
su mongodb
source /home/mongodb/.bashrc
```

#### MongoDB Compass Download (GUI) ubuntu coin interfaz gráfica

```bash
wget https://downloads.mongodb.com/compass/mongodb-compass_1.42.1_amd64.deb

```

## conexión servidor mongodb

### conexión servidor mongodb interna

```bash
# string de conexión [mongodb://192.168.0.50:27017/]
# conexión desde terminal

mongo "mongodb://192.168.0.50:27017/"

```

### conexión servidor mongodb externa

```bash
# string de conexión [mongodb://192.168.0.50:27017/]
# conexión desde terminal

mongo "mongodb://192.168.0.50:27017/"

```

![sbd0201-q10-external-mongodb-client](sbd0201-q10-external-mongodb-client.png)

```bash
# conexión habitual
# en el caso de la practica no nos conectamos mediante un usuario
username=mongodb
mongo_server_ip=192.168.0.50
mongo "mongodb://$username@$mongo_server_ip:27017"

mongo "mongodb://mongodb@192.168.0.50:27017"
```
