<!-- cSpell:ignore netplan,bieitoserver,tunombreserver,autoarrancarlos
-->

# SBD02-01

## Practica Instalación servidor MongoDB

DNI: 39465322J
Alumno : Bieito Sousa Barreiro

Url Entrega : [Instalación servidor MongoDB](https://fpadistancia.edu.xunta.gal/mod/assign/view.php?id=806243)

<!-- pagebreak -->

## Indice

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [SBD02-01](#sbd02-01)
  - [Practica Instalación servidor MongoDB](#practica-instalación-servidor-mongodb)
  - [Indice](#indice)
    - [Objetivo](#objetivo)
    - [Entorno](#entorno)
    - [Instrucciones de entrega](#instrucciones-de-entrega)
    - [Enunciado](#enunciado)
      - [📄 /etc/mongod.conf](#-etcmongodconf)
      - [📄 etc/systemd/system/mongod.service](#-etcsystemdsystemmongodservice)
      - [1.- Captura de pantalla de algún comando en el sistema operativo Ubuntu Server en el que se vea la cantidad de memoria RAM total y disponible.](#1--captura-de-pantalla-de-algún-comando-en-el-sistema-operativo-ubuntu-server-en-el-que-se-vea-la-cantidad-de-memoria-ram-total-y-disponible)
      - [Justifica con tus palabras como has elegido la cantidad de RAM que asignar a este servidor. Es necesario referenciar una fuente fiable y oficial que respalde tu elección.](#justifica-con-tus-palabras-como-has-elegido-la-cantidad-de-ram-que-asignar-a-este-servidor-es-necesario-referenciar-una-fuente-fiable-y-oficial-que-respalde-tu-elección)
      - [2.- Captura de pantalla de un `ping -c 4 www.google.es` para confirmar que hay conexión a internet desde el servidor.](#2--captura-de-pantalla-de-un-ping--c-4-wwwgooglees-para-confirmar-que-hay-conexión-a-internet-desde-el-servidor)
      - [Explica brevemente (el detalle ya está en una práctica anterior) como has configurado la máquina virtual y/o el propio servidor para que tenga IP fija y pueda navegar.](#explica-brevemente-el-detalle-ya-está-en-una-práctica-anterior-como-has-configurado-la-máquina-virtual-yo-el-propio-servidor-para-que-tenga-ip-fija-y-pueda-navegar)
      - [3.- Debe existir un usuario específico para MongoDB, hay que crearlo si es necesario.](#3--debe-existir-un-usuario-específico-para-mongodb-hay-que-crearlo-si-es-necesario)
        - [Creamos el usuario y lo agregamos al grupo](#creamos-el-usuario-y-lo-agregamos-al-grupo)
      - [Captura la pantalla donde se pueda ver el propietario y el grupo de los ejecutables de MongoDB. Indica con tus palabras que comando usas y como interpretas su salida para obtener la información solicitada en la captura.](#captura-la-pantalla-donde-se-pueda-ver-el-propietario-y-el-grupo-de-los-ejecutables-de-mongodb-indica-con-tus-palabras-que-comando-usas-y-como-interpretas-su-salida-para-obtener-la-información-solicitada-en-la-captura)
      - [4.- La ruta de los datos que almacenará MongoDB deben estar en la carpeta `/home/bieito/datos`.](#4--la-ruta-de-los-datos-que-almacenará-mongodb-deben-estar-en-la-carpeta-homebieitodatos)
      - [5.- Captura de pantalla donde se vea propietario y grupo de la carpeta `/home/bieito/datos`. Explica con tus palabras la relación que debe haber entre propietario de esa carpeta y el propietario de MongoDB](#5--captura-de-pantalla-donde-se-vea-propietario-y-grupo-de-la-carpeta-homebieitodatos-explica-con-tus-palabras-la-relación-que-debe-haber-entre-propietario-de-esa-carpeta-y-el-propietario-de-mongodb)
        - [Establecemos los permisos de la estructura de ficheros y directorios.](#establecemos-los-permisos-de-la-estructura-de-ficheros-y-directorios)
        - [Permisos aclaración](#permisos-aclaración)
      - [6.- Elige una ruta para el archivo de log. Captura la pantalla en la que se vea como indicas a MongoDB la ruta del archivo de log. Explica con tus palabras lo que muestras en la captura de pantalla.](#6--elige-una-ruta-para-el-archivo-de-log-captura-la-pantalla-en-la-que-se-vea-como-indicas-a-mongodb-la-ruta-del-archivo-de-log-explica-con-tus-palabras-lo-que-muestras-en-la-captura-de-pantalla)
      - [7.- Configura el servidor MongoDB para que acepte conexiones todas las conexiones entrantes. El puerto de escucha seguirá siendo el 27017. Captura la pantalla de como indicas a MongoDB esta configuración.](#7--configura-el-servidor-mongodb-para-que-acepte-conexiones-todas-las-conexiones-entrantes-el-puerto-de-escucha-seguirá-siendo-el-27017-captura-la-pantalla-de-como-indicas-a-mongodb-esta-configuración)
      - [8.- El servidor MongoDB debe tener un servicio asociado que lo inicie automáticamente en cada arranque. Captura la pantalla donde se vea el “status” del servicio de MongoDB donde se vea activo. Explica con tus palabras la interpretación que haces de la salida del estado del servicio.](#8--el-servidor-mongodb-debe-tener-un-servicio-asociado-que-lo-inicie-automáticamente-en-cada-arranque-captura-la-pantalla-donde-se-vea-el-status-del-servicio-de-mongodb-donde-se-vea-activo-explica-con-tus-palabras-la-interpretación-que-haces-de-la-salida-del-estado-del-servicio)
      - [9.- Conecta a la interfaz CLI de MongoDB ejecutando el cliente desde el propio servidor. Captura la pantalla en la que se vea el prompt de la interfaz por comandos de MongoDB.](#9--conecta-a-la-interfaz-cli-de-mongodb-ejecutando-el-cliente-desde-el-propio-servidor-captura-la-pantalla-en-la-que-se-vea-el-prompt-de-la-interfaz-por-comandos-de-mongodb)
      - [10.-Instala cualquier cliente de MongoDB en otro equipo. Captura de pantalla donde se vea que tu cliente se ha conectado correctamente al servidor MongoDB remoto. Explica brevemente que has hecho para que el equipo cliente y el equipo servidor puedan establecer la conexión.](#10-instala-cualquier-cliente-de-mongodb-en-otro-equipo-captura-de-pantalla-donde-se-vea-que-tu-cliente-se-ha-conectado-correctamente-al-servidor-mongodb-remoto-explica-brevemente-que-has-hecho-para-que-el-equipo-cliente-y-el-equipo-servidor-puedan-establecer-la-conexión)

<!-- /code_chunk_output -->
<!-- pagebreak -->

### Objetivo

• Destacar la importancia de tener un usuario para cada responsabilidad, en este caso uno para la gestión de mongoDB a nivel de sistema operativo.
• Personalizar y configurar las rutas de datos y logs (y en general el archivo de configuración) en un servidor mongoDB
• Conocer las rutas y, especialmente el puerto predeterminado.
• Interactuar con las aplicaciones a través de sus servicios para autoarrancarlos, pararlos, reiniciarlos,…
• Comprender el papel de servidor y el papel de cliente incluso en la misma máquina.
• Configurar un cliente MongoDB con IP y puerto

<!-- pagebreak -->

### Entorno

Crea una máquina virtual para instalar un servidor MongoDB. La máquina virtual debe tener las siguientes características:

Ubuntu Server.
2 procesadores.
con conexión a internet.
IP fija
Nombre del servidor: tunombreserver
Nombre de usuario: tu nombre
memoria RAM mínima recomendable para usar MongoDB (justificarás cantidad en una de las preguntas.)
Para la última pregunta necesitarás otro equipo que también puede ser virtual o tu propia máquina real. Este segundo equipo solo se usará como cliente para conectar contra la base de datos por lo tanto puedes disponer como quieras del sistema operativos, configuración, etc.

```bash
name bieitoserver
2 procesadores.
user bieito
pws abc123.
ram 4 GB. (4099 MB)
ip 192.168.0.51/24
```

No es necesario realizar capturas de pantalla de la preparación de la máquina virtual.

### Instrucciones de entrega

Elabora y envía un documento PDF con tu nombre completo y DNI en la portada. Usa una nueva hoja por cada apartado, copia el enunciado y contesta. Las capturas de pantalla deben ser de “pantalla completa”, no solo del detalle.

<!-- pagebreak -->

### Enunciado

> A lo largo de la practica are referencia a los siguientes archivos de configuración

#### 📄 /etc/mongod.conf

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

#### 📄 etc/systemd/system/mongod.service

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

<!-- pagebreak -->

#### 1.- Captura de pantalla de algún comando en el sistema operativo Ubuntu Server en el que se vea la cantidad de memoria RAM total y disponible.

```bash
bieito@bieitoserver:~$ free -h
               total        used        free      shared  buff/cache   available
Mem:           3,8Gi       194Mi       3,3Gi       1,0Mi       300Mi       3,4Gi
Swap:          3,8Gi          0B       3,8Gi
bieito@bieitoserver:~$ cat /proc/meminfo | grep Mem
MemTotal:        4006948 kB
MemFree:         3499584 kB
MemAvailable:    3584084 kB
bieito@bieitoserver:~$
```

![sbd0201-q1-ram](sbd0201-q1-ram.png)

#### Justifica con tus palabras como has elegido la cantidad de RAM que asignar a este servidor. Es necesario referenciar una fuente fiable y oficial que respalde tu elección.

En la pagina oficial comentan claramente que la RAM minima son de 4G
[ver requisitos mínimos](https://www.mongodb.com/docs/cloud-manager/tutorial/provisioning-prep/#:~:text=System%20Requirements,-Hardware%20and%20Software&text=Each%20host%20must%20meet%20the,least%204%20GB%20of%20RAM.)

> System Requirements
> Hardware and Software
> Each host must meet the following requirements.
> At least 10 GB of free disk space plus whatever space is necessary to hold your MongoDB data.
> At least 4 GB of RAM.
> If you use AWS EC2 instances, you should use a minimum of an m5.large instance.
> The MongoDB Agent must be installed only on 64-bit architectures.

<!-- pagebreak -->

#### 2.- Captura de pantalla de un `ping -c 4 www.google.es` para confirmar que hay conexión a internet desde el servidor.

![sbd0201-q2-ping](sbd0201-q2-ping.png)

<!-- pagebreak -->

#### Explica brevemente (el detalle ya está en una práctica anterior) como has configurado la máquina virtual y/o el propio servidor para que tenga IP fija y pueda navegar.

- En este caso puse el adaptador de red de la maquina en modo puente para poder conectarme via ssh
- con `ip a` identifique que la interfaz de red era `enp0s3`
- con `sudo nano /etc/netplan/00-installer-config.yaml` definí la ip 192.163.0.50 la mascara de red (255.255.255.255.0) 0 (/24) y la puerta de enlace (192.168.0.1) y los dns (8.8.8.8)

📄 `/etc/netplan/00-installer-config.yaml` [root]

```bash
network:
  ethernets:
    enp0s3:
      addresses:
        - 192.168.0.51/24
      routes:
        - to: default
          via: 192.168.0.1
      nameservers:
        addresses:
          - 8.8.8.8
  version: 2
```

<!-- pagebreak -->

--- Instala MongoDB server con las siguientes especificaciones: ---

#### 3.- Debe existir un usuario específico para MongoDB, hay que crearlo si es necesario.

##### Creamos el usuario y lo agregamos al grupo

```bash
# creamos el usuario mongodb
sudo adduser mongodb
# añadimos usuario mongodb a grupo sudo
sudo usermod -aG sudo mongodb
```

#### Captura la pantalla donde se pueda ver el propietario y el grupo de los ejecutables de MongoDB. Indica con tus palabras que comando usas y como interpretas su salida para obtener la información solicitada en la captura.

explicación breve :

- para que el usuario `mongodb` pueda ejecutar el servicio sin problemas los ejecutables `mongod`y `mongos`
- pertenecerán al usuario `mongodb` con permisos `lectura , escritura , ejecución` - `(7)` - `(rwx)`
- al grupo `mongodb` con permisos `lectura , - , ejecución` - `(5)` - `(r-x)`
- `otros` con permisos `lectura , - , ejecución` - `(5)` - `(r-x)`

[explicación detallada permisos del entorno de usuario, grupos y otros en el punto 5](#5--captura-de-pantalla-donde-se-vea-propietario-y-grupo-de-la-carpeta-homebieitodatos-explica-con-tus-palabras-la-relación-que-debe-haber-entre-propietario-de-esa-carpeta-y-el-propietario-de-mongodb)

![sbd0201-q3-user-mongodb](sbd0201-q3-user-mongodb.png)

<!-- pagebreak -->

#### 4.- La ruta de los datos que almacenará MongoDB deben estar en la carpeta `/home/bieito/datos`.

hay dos formas de indicarlo:

- mediante comando directo

  - `mongod --dbpath ${data_path}`

- mediante un archivo de configuración

  - `/etc/mongod.conf`
  - en el archivo usaremos la estructura

  ```bash
    storage:
     dbPath: ${data_path}
  ```

```bash
# mediante comandos directo
mongod --dbpath /home/bieito/datos
# mediante configuración
cat /etc/mongod.conf| grep -E "storage|dbPath"
############
storage:
   dbPath: /home/bieito/datos
############
```

Captura de pantalla donde se vea como indicas a MongoDB la ruta de los datos.

![mongod-conf](mongod-conf.png)

<!-- pagebreak -->

#### 5.- Captura de pantalla donde se vea propietario y grupo de la carpeta `/home/bieito/datos`. Explica con tus palabras la relación que debe haber entre propietario de esa carpeta y el propietario de MongoDB

##### Establecemos los permisos de la estructura de ficheros y directorios.

en `\home\bieito` [descripción de una manera más optima](#permisos-aclaración)

- `otros: r-x` necesitamos con el usuario `mongodb` permisos de lectura y ejecución para poder llegar a los directorios de la estructura mongodb situados en `\home\bieito\`

`drwxr-xr-x 13 bieito  bieito  4096 feb 27 00:35 bieito`

para evitar problemas en todo la estructura mongodb [descripción de una manera más optima](#permisos-aclaración)

- `/home/bieito/mongo` # ejecutables mongod mongos
- `/home/bieito/log` # archivos de log de mongo
- `/home/bieito/datos` # archivos datos de mongo
- `/home/bieito/mongo-tools` # ejecutables de mongo-tools
- `/home/bieito/mongo-download` # donde descargo los .tar de la web official

este entorno y los ejecutables `mongod` y `mongos` va a pertenecer a

- usuario `mongodb` lectura , escritura y ejecución : `drwx`.
- grupo `mongodb` lectura y ejecución : `r-x`
- otros lectura y ejecución : `r-x`
- el único que tiene permisos de escritura es el usuario mongodb
- entiendo que las operaciones del servidor de mongod se ejecutan a trabes de `mongodb` por lo tanto este usuario escribiría en data, log y es el que ejecutaría los binarios de cara al servidor.
- de cara al cliente como tienen permisos de lectura y escritura los demás usuarios podría efectuar acciones.

```bash
drwxr-xr-x  2 mongodb mongodb  4096 feb 24 04:49 log
drwxr-xr-x  3 mongodb mongodb  4096 feb 24 05:29 mongo
drwx------  3 bieito  bieito   4096 feb 27 00:30 .mongodb
drwxr-xr-x  2 mongodb mongodb  4096 feb 27 00:34 mongo-download
drwxr-xr-x  3 mongodb mongodb  4096 feb 19 11:00 mongosh
drwxr-xr-x  3 mongodb mongodb  4096 feb 27 00:32 mongo-tools
```

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
# verificar
sudo ls -la /home/ | grep "bieito"
sudo ls -la /home/bieito/
sudo ls -la /home/bieito/mongo/bin | grep -E 'mongod|mongos'

```

<!-- pagebreak -->

Captura la pantalla donde se pueda ver el propietario y el grupo de los ejecutables de MongoDB.

![sbd0201-q3-user-mongodb](sbd0201-q3-user-mongodb.png)

<!-- pagebreak -->

##### Permisos aclaración

> Aclaración
>
> > En `\home\bieito`
> > ⚠️ Esta practica puede ser peligrosa en un entorno ideal crearíamos un grupo `manageMongoDB` cuyo objetivo fuese gestionar la estructura de mongodb y asignaríamos a `mongodb` en un grupo , evitando asi un mal uso de los permisos `otros`.
> > En `entorno carpetas y directorios de mongodb dentro de \home\bieto\...`
> > ⚠️ un poco la misma idea, lo optimo seria que las carpetas del entorno citadas a continuación, pertenecieran a `manageMongoDB` y este grupo tuviese `rwx` sobre las carpetas del entorno.
> > ❓️❓️ Duda entiendo que si quisiéramos afinar lo máximo posible podríamos plantear la estructura de permisos sobre el entorno de esta manera `rwxrwx---  2 bieito manageMongoDB` entendiendo que `mongodb` a trabes del grupo `manageMongoDB` podría interactuar con el entorno en optimas condiciones y el usuario `bieito` mantendría permisos en su home de una manera mas optima.
> > Pero se me plantea la duda si daría algún tipo de problema, cuando definimos el servicio y indicamos que usuario y que grupo lo ejecuta entiendo que quedaría de la siguiente manera :

```bash
[Service]
Type=simple
User=mongodb
Group=manageMongoDB
```

<!-- pagebreak -->

#### 6.- Elige una ruta para el archivo de log. Captura la pantalla en la que se vea como indicas a MongoDB la ruta del archivo de log. Explica con tus palabras lo que muestras en la captura de pantalla.

hay dos formas de indicarlo:

- mediante comando directo

  - `mongod --logpath ${log_archive.log}`

- mediante un archivo de configuración

  - `/etc/mongod.conf`
  - en el archivo usaremos la estructura

  ```bash
    systemLog:
      destination: file
      path: "${log_path}"
      logAppend: true
  ```

```bash
# mediante comandos directo
mongod --logpath /home/bieito/log/mongo.log
# mediante configuración
cat /etc/mongod.conf| grep -E "systemLog|destination|path|logAppend"
############
systemLog:
   destination: file
   path: "/home/bieito/log/mongo.log"
   logAppend: true
############
```

![mongod-conf](mongod-conf.png)

<!-- pagebreak -->

#### 7.- Configura el servidor MongoDB para que acepte conexiones todas las conexiones entrantes. El puerto de escucha seguirá siendo el 27017. Captura la pantalla de como indicas a MongoDB esta configuración.

> [bindIp atributos](https://www.mongodb.com/docs/manual/reference/configuration-options/#std-label-configuration-options:~:text=Para%20vincularse%20a%20todas%20las%20direcciones%20IPv4%2C%20ingrese%200.0.0.0.) > `bindIp`Para vincularse a todas las direcciones IPv4, ingrese 0.0.0.0.

hay dos formas de indicarlo:

- entendemos 0.0.0.0 como que todas las ips están permitidas
- mediante comando directo

  - `mongod --bind_ip ${ip_permitidas} --port ${puerto}`

- mediante un archivo de configuración

  - `/etc/mongod.conf`
  - en el archivo usaremos la estructura

  ```bash
    net:
      port: ${puerto}
      bindIp: ${ip_permitidas}
  ```

```bash
# mediante comandos directo
mongod --bind_ip 0.0.0.0 --port 27017
# mediante configuración
cat /etc/mongod.conf| grep -E "net|port|bindIp"
############
net:
  port: 27017
  bindIp: 0.0.0.0
############
```

![mongod-conf](mongod-conf.png)

<!-- pagebreak -->

#### 8.- El servidor MongoDB debe tener un servicio asociado que lo inicie automáticamente en cada arranque. Captura la pantalla donde se vea el “status” del servicio de MongoDB donde se vea activo. Explica con tus palabras la interpretación que haces de la salida del estado del servicio.

El servicio nos indica que :

- El servicio esta activo y se esta ejecutando `active (running)`
- Se ejecuta la configuración del servicio del fichero `/etc/systemd/system/mongod.service` al iniciar el sistema, `loaded (/etc/systemd/system/mongod.service; enabled`,
- RAM tareas y CPU en uso
- El comando de ejecución es `/home/bieito/mongo/bin/mongod --config /etc/mongod.conf`

```bash
#  servicio
sudo systemctl start mongod.service # iniciar
sudo systemctl status mongod.service # ver estado
sudo systemctl enable mongod.service # persistencia , iniciar al inicio del sistema
```

| atributo | desc                                                                                                   | value                                                                                     | desc                                                                                                                                                                                    |
| -------- | ------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Loaded   | Indica el estado de carga del servicio.                                                                | loaded (/etc/systemd/system/mongod.service; enabled; vendor preset: enabled)              | En este caso, el servicio mongod está cargado desde el archivo /etc/systemd/system/mongod.service y está habilitado para arrancar automáticamente en el arranque del sistema (enabled). |
| Active   | Indica el estado actual del servicio.                                                                  | active (running) since Thu 2024-02-29 15:06:50 UTC; 32min ago                             | En este caso, el servicio mongod está activo y en ejecución desde la fecha y hora indicadas.                                                                                            |
| Main     | Indica el Identificador de Proceso Principal                                                           | PID: 665 (mongod)                                                                         | PID: El PID (Identificador de Proceso Principal) del proceso principal del servicio mongod.                                                                                             |
| Tasks    | El número de tareas relacionadas con el servicio mongod.                                               | 32 (limit: 4559)                                                                          | 32 tareas de un máximo de 4559                                                                                                                                                          |
| Memory   | La cantidad de memoria que está utilizando el servicio mongod.                                         | 252.8M                                                                                    | el servicio mongod esta usando 252.8M de memoria                                                                                                                                        |
| CPU      | El tiempo de CPU utilizado por el servicio mongod.                                                     | 18.537s                                                                                   | el servicio mongod usa la CPU 18.537s                                                                                                                                                   |
| CGroup   | La unidad de control de recursos del servicio mongod. salida de `sudo systemctl status mongod.service` | /system.slice/mongod.service└─665 /home/bieito/mongo/bin/mongod --config /etc/mongod.conf | el servicio ejecuta el comando `/home/bieito/mongo/bin/mongod --config /etc/mongod.conf`                                                                                                |

```bash
● mongod.service
     Loaded: loaded (/etc/systemd/system/mongod.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2024-02-29 15:06:50 UTC; 32min ago
   Main PID: 665 (mongod)
      Tasks: 32 (limit: 4559)
     Memory: 252.8M
        CPU: 18.537s
     CGroup: /system.slice/mongod.service
             └─665 /home/bieito/mongo/bin/mongod --config /etc/mongod.conf

feb 29 15:06:50 bieitoserver systemd[1]: Started mongod.service.
feb 29 15:18:57 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:1: Assignment outside of section. Ignoring.
feb 29 15:18:57 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:2: Assignment outside of section. Ignoring.
feb 29 15:18:57 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:3: Assignment outside of section. Ignoring.
feb 29 15:18:57 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:4: Assignment outside of section. Ignoring.
feb 29 15:39:12 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:1: Assignment outside of section. Ignoring.
feb 29 15:39:12 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:2: Assignment outside of section. Ignoring.
feb 29 15:39:12 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:3: Assignment outside of section. Ignoring.
feb 29 15:39:12 bieitoserver systemd[1]: /etc/systemd/system/mongod.service:4: Assignment outside of section. Ignoring.
```

![sbd0201-q8-service-mongodb](sbd0201-q8-service-mongodb.png)

<!-- pagebreak -->

#### 9.- Conecta a la interfaz CLI de MongoDB ejecutando el cliente desde el propio servidor. Captura la pantalla en la que se vea el prompt de la interfaz por comandos de MongoDB.

![sbd0201-q9-internal-mongodb-client](sbd0201-q9-internal-mongodb-client.png)

install MongoDB Shell Download [mongosh]

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

conexión

```bash
mongosh
```

install MongoDB Command Line Database Tools Download
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

<!-- pagebreak -->

#### 10.-Instala cualquier cliente de MongoDB en otro equipo. Captura de pantalla donde se vea que tu cliente se ha conectado correctamente al servidor MongoDB remoto. Explica brevemente que has hecho para que el equipo cliente y el equipo servidor puedan establecer la conexión.

```bash
# string de conexión [mongodb://192.168.0.50:27017/]
# conexión desde terminal

mongo "mongodb://192.168.0.50:27017/"

```

![sbd0201-q10-external-mongodb-client](sbd0201-q10-external-mongodb-client.png)

```bash
# en el caso de la practica no nos conectamos sin indicar usuario
mongo "mongodb://192.168.0.50:27017/"
# conexión habitual
username=mongodb
mongo_server_ip=192.168.0.50
mongo "mongodb://$username@$mongo_server_ip:27017"

mongo "mongodb://mongodb@192.168.0.50:27017"
```
