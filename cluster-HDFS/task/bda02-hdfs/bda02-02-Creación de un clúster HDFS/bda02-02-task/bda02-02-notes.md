<!-- cSpell:ignore discogrande,curtin,descárgalo,descomprímelo, dfadmin,netplan,subiquity,hadoop,redhat,subtag,esbenp,ethernets,ecdsa,openssh,fdisk,namenode,datanode,decomisionado,hdfs,dfsadmin,reconfig,fsimage,datanodes,httpfs,jobhistory,namenodes,jconsole,getconf,Xceivers,pagebreak,Diffie-Hellman,
-->

# bda02-02-notes

## red

### red - conceptos

### red - archivos

#### 📄 `/etc/netplan/00-installer-config.yaml` [root]

> Configurar las interfaces de red, definir ip mascara red en cada una de las mismas

```bash
# This is the network config written by 'subiquity'
# nota bie1 - 192.168.0.101
# nota bie2 - 192.168.0.102
# nota bie3 - 192.168.0.103
# nota bie4 - 192.168.0.104
network:
  ethernets:
    enp0s3:
      addresses:
        - 192.168.0.101/24
      routes:
        - to: default
          via: 192.168.0.1
      nameservers:
        addresses:
          - 8.8.8.8
  version: 2
```

### 📄 `/etc/hosts` [root]

> definir "dns" local

```bash
127.0.0.1 localhost

# hosts 192.168.0.10X bie(n)
192.168.0.100   bieTemplate
192.168.0.101   bie1
192.168.0.102   bie2
192.168.0.103   bie3
192.168.0.104   bie4
# [...]
```

#### 📄 `/etc/hostname` [root]

> nombre del equipo

```bash
# nota bie1
# nota bie2
# nota bie3
# nota bie4
bie1
```

### red - comandos

#### basic

```bash
ip a # ver dirección ip y mascara
ip route #consultar tabla de rutas
sudo netplan try #
```

#### Verificar configuración de los archivos

```bash
echo "[/etc/netplan/00-installer-config.yaml]";
cat /etc/netplan/00-installer-config.yaml ;
echo "[/etc/hosts]"; head /etc/hosts ;
echo "[/etc/hostname]" ;cat /etc/hostname
```

#### verificar comunicación entre m.v

```bash
ping -q -c 2 bie1 ;
ping -q -c 2 -v bie2;
ping -q -c 2 bie3;
ping -q -c 2 bie4;
ping -q -c 1 8.8.8.8;
ping -q -c1 google.com
```

## shh

### ssh - conceptos

#### ssh basic

Por ejemplo, si el nombre de usuario es "usuario", las claves públicas por defecto estarán en:
|algoritmo de creación | clave publica | clave privada |
|-|-|-|
|RSA | /home/usuario/.ssh/id_rsa.pub | /home/usuario/.ssh/id_rsa |
|DSA | /home/usuario/.ssh/id_dsa.pub | /home/usuario/.ssh/id_dsa |
|ECDSA | /home/usuario/.ssh/id_ecdsa.pub | /home/usuario/.ssh/id_ecdsa |
|Ed25519 | /home/usuario/.ssh/id_ed25519.pub | /home/usuario/.ssh/id_ed25519 |

crear clave publica y privada

| concepto   | explicación                                              |
| ---------- | -------------------------------------------------------- |
| ssh-keygen | `ssh-keygen -t rsa -f /home/hadoop/.ssh/bie1`            |
| -t         | algoritmo usado                                          |
| -f         | ubicación del directorio para las claves ssh del usuario |

para no tener que introducir una contraseña, podemos copiar la clave publica en otros nodos

crear clave publica y privada

| concepto    | explicación                                                                               |
| ----------- | ----------------------------------------------------------------------------------------- |
| ssh-copy-id | `ssh-copy-id -i /home/hadoop/.ssh/bie1.pub hadoop@bie2`                                   |
| -i          | especifica la ubicación del archivo de clave pública que deseas copiar al servidor remoto |
| $1          | dirección del servidor remoto al que deseas copiar la clave pública                       |

#### A nivel de Usuario

`ls -la ~/.ssh/` --> directorio config. ssh a nivel de sistema

entendiendo `nodo`como nombre definido

`archivo *nodo` --> Clave privada
`archivo *nodo.pub` --> Clave publica
`known_hosts` almacena las claves públicas de los servidores a los que un usuario se ha conectado anteriormente a través del protocolo SSH.
`archivo authorized_keys`
especificar qué claves públicas de SSH están autorizadas para acceder a una cuenta de usuario específica a través de SSH sin necesidad de proporcionar una contraseña.
Cuando un usuario intenta acceder a un servidor SSH, el servidor verifica si la clave pública utilizada por el cliente se encuentra en el archivo authorized_keys correspondiente a la cuenta de usuario a la que se está intentando acceder. Si la clave pública del cliente coincide con alguna de las claves públicas listadas en authorized_keys, el acceso se permite sin requerir una contraseña.

#### A nivel de Sistema

`/etc/ssh/sshd_config` --> directorio config. ssh a nivel de sistema

##### !! important nivel usuario

`/etc/ssh/ssh_config`

> Este archivo contiene la configuración global para clientes SSH. Define opciones de configuración predeterminadas para la ejecución de comandos ssh desde la línea de comandos.

- `La opción IdentityFile`
  se usa para especificar la ubicación de la clave privada que el cliente SSH utilizará durante la autenticación con el servidor SSH.

`ssh_config.d`

Este directorio puede contener archivos adicionales de configuración para clientes SSH. Estos archivos se incluyen y se aplican junto con el ssh_config principal.

##### !! important nivel servidor

`sshd_config.d`

Similar al directorio ssh_config.d, este directorio puede contener archivos adicionales de configuración para el servidor SSH. Estos archivos se incluyen y se aplican junto con el sshd_config principal.

`sshd_config`
Este archivo contiene la configuración del servidor SSH. Define opciones como el puerto de escucha, la autenticación permitida, configuración de claves, etc.

##### others

`moduli`:

Este archivo contiene los parámetros de los grupos de moduli utilizados para la negociación de claves Diffie-Hellman en SSH. Estos parámetros afectan la seguridad de la conexión.

`ssh_host_ecdsa_key y ssh_host_ecdsa_key.pub`

Estos archivos contienen la clave privada y pública, respectivamente, para el algoritmo de clave ECDSA (Elliptic Curve Digital Signature Algorithm) utilizado por el servidor SSH para autenticación y establecimiento de claves seguras.

`ssh_host_ed25519_key y ssh_host_ed25519_key.pub`

Contienen la clave privada y pública, respectivamente, para el algoritmo de clave Ed25519 utilizado por el servidor SSH.

`ssh_host_rsa_key y ssh_host_rsa_key.pub`

Contienen la clave privada y pública, respectivamente, para el algoritmo de clave RSA utilizado por el servidor SSH.

`ssh_host_dsa_key y ssh_host_dsa_key.pub`

Contienen la clave privada y pública, respectivamente, para el algoritmo de clave DSA (Digital Signature Algorithm) utilizado por el servidor SSH.

`ssh_import_id`

Este archivo se utiliza para importar identidades de claves públicas a la base de datos de autenticación SSH.

### ssh - archivos

📄 /etc/ssh/ssh_config [root]

```bash
IdentityFile ~/.ssh/nodo1
```

### ssh - comandos

#### instal ssh

```bash
# instalar ssh server
sudo apt install openssh-server
```

#### create private and publics keys

```bash
# crear pareja de llaves publica y privada
ssh-keygen
/home/hadoop/.shh/nodo2
# enter dejar contraseña en blanco
# enter dejar repetir contraseña en blanco
ls -la .ssh/ # verificar

# en un comando
ssh-keygen -t rsa -f /home/hadoop/.ssh/bie1 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hadoop/.ssh/bie2 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hadoop/.ssh/bie3 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hadoop/.ssh/bie4 ; ls -la .ssh/
```

#### definir ubicación de la clave privada que el cliente SSH

```bash
 sudo nano /etc/ssh/ssh_config
 IdentityFile ~/.ssh/nodo1 # escribir al final del archivo
 ## un solo comando
 sudo bash -c 'echo "IdentityFile ~/.ssh/bie1" >> /etc/ssh/ssh_config'
 sudo bash -c 'echo "IdentityFile ~/.ssh/bie2" >> /etc/ssh/ssh_config'
 sudo bash -c 'echo "IdentityFile ~/.ssh/bie3" >> /etc/ssh/ssh_config'
 sudo bash -c 'echo "IdentityFile ~/.ssh/bie4" >> /etc/ssh/ssh_config'
 ## verificar
 cat /etc/ssh/ssh_config | grep "IdentityFile"
```

#### shared public keys to other nodes

```bash
#nodo1
ssh-copy-id -i /home/hadoop/.ssh/bie1.pub hadoop@bie1
# lo mismo con los demás
ssh-copy-id -i /home/hadoop/.ssh/bie1.pub hadoop@bie2
ssh-copy-id -i /home/hadoop/.ssh/bie1.pub hadoop@bie3
ssh-copy-id -i /home/hadoop/.ssh/bie1.pub hadoop@bie4
# un solo comando
for nodo in bie1 bie2 bie3 bie4;
do ssh-copy-id -i /home/hadoop/.ssh/bie1.pub hadoop@$nodo;
done
```

#### copia de archivos

```bash
# copiar carpeta hadoop a los otros nodos
scp -r /home/hadoop/hadoop hadoop@bie2:/home/hadoop
```

## disco

### disco - conceptos

### disco - archivos

📄 /etc/fstab [root]

> Persistencia ruta de montage

```bash
# /boot was on /dev/sda2 during curtin installation
/dev/disk/by-uuid/de5fd9a1-953c-4dfe-a534-be2976a839b1 /boot ext4 defaults 0 1
/swap.img       none    swap    sw      0       0
# montaje persistente de disco grande
# <file system> <mount point>                   <type>  <options>  <dump>  <pass>
/dev/sbd1       /home/hadoop/discogrande        ext4    defaults     0       0
```

### disco - comandos

```bash
# --- Paso a paso --- #
lsblk
sudo fdisk /dev/sbd
p # imprimo la info del disco
g # cambio a gpt
n # creo una nueva partición
# intro
# intro
# intro
w # escribir los cambios
sudo mkfs.ext4 /dev/sbd1
# crear ruta de montaje
mkdir discogrande
# montar partición
sudo mount /dev/sbd1 /home/hadoop/discogrande/
# persistencia
 sudo nano /etc/fstab
# añadir --> /dev/sbd1    /home/hadoop/discogrande      ext4  defaults    0     0
# cambiar permisos a usuario hadoop
sudo chown -R hadoop:hadoop /home/hadoop/discogrande

# --- en un solo comando --- #
echo -e "g\nn\n\n\n\nw\n" | sudo fdisk /dev/sbd;
sudo mkfs.ext4 /dev/sbd1;
mkdir discogrande;
sudo mount /dev/sbd1 /home/hadoop/discogrande/;
sudo sh -c 'printf "/dev/sbd1\t/home/hadoop/discogrande\text4\tdefaults\t0\t0\n">> /etc/fstab';

sudo chown -R hadoop:hadoop /home/hadoop/discogrande;
# --- Verificar --- #
lsblk | grep "discogrande";
ls -la | grep "discogrande";
```

### hadoop

### hadoop - conceptos

**_📄 core-site.xml [namenode]_**
|propiedad| descripción|
|-|-|
|`dfs.namenode.name.dir`|Ruta donde esta guarda la tabla de direcciones de namenode|
|`dfs.replication`| Cuando guardas un archivo en Hadoop, el archivo se divide en fragmentos de datos llamados "bloques" , pore defecto (128 MB). estos bloques se guardan en n nodos siendo n el valor de dfs.replication, en este caso como el valor es 2 se guarda cada "bloque" en 2 nodos.|
|actúa|en este archivo el nodo1 actúa como namenode, por lo cual unicamente definimos en la configuración relativa al proceso de namenode, mientras que nodo2,3,4 van a actuará como datanode y definimos en ello de manera idéntica la configuración relativa a datanode|

**_📄 core-site.xml [datanode]_**

**nodo - modo dead**

para que hadoop declare un nodo muerto:";
1.- tiene que pasar un nodo sin responder 10 latidos de [dfs.heartbeat.interval] (3 x defecto) segundos ";
2.- dos periodos de gracia de [dfs.namenode.heartbeat.recheck-interval] (5 min por defecto) cada uno";
esto ocurre para asegurarse plenamente de que el nodo no es funcional antes de que se muevan cantidades muy grandes de información implicando la saturación de recursos ";

**nodo - modo mantenimiento**

**nodo - modo decomisionado**

operación de mantenimiento de gran duración
ejemplo cambiar todos los módulos del rack

### hadoop - archivos

📄 `nano /home/hadoop/hadoop/etc/hadoop/core-site.xml`
¿Qué estamos indicando en esa configuración?

> Este archivo `📄 core-site.xml` se utiliza para especificar la configuración centralizada para el sistema de archivos y otros aspectos fundamentales del clúster de Hadoop

| type      | Concepto           | descripción                                                                                                                                                            |
| --------- | ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Propiedad | `fs.defaultFS`     | Propiedad que define el sistema de archivos por defecto que utilizará Hadoop                                                                                           |
| value     | `hdfs://bie1:9000` | `hdfs` Sistema de archivos por defecto utilizado por Hadoop será HDFS (Hadoop Distributed File System) </br>`bie1` la dirección del namenode </br>`:9000` puerto 9000. |

¿Por qué todos los nodos comparten la la misma configuración en el archivo core-site.xml?

> En este caso definimos que el nodo bie1 actuara como namenode esta configuración se aplica en todos los nodos, puesto que es una configuración global y todos ellos tienen que saber la dirección del nodo que actuara como namenode, es decir donde se guardaran la tabla direcciones.

```xml
<configuration>
<!--
  `fs.defaultFS`
    propiedad que define el sistema de archivos por defecto que utilizará Hadoop , indicamos la dirección del namenode a la que debe conectarse Hadoop
   hdfs://bie1:9000=
  `hdfs`   sistema de archivos por defecto utilizado por Hadoop será HDFS (Hadoop Distributed File System)
  `bie1` la dirección del namenode
  `:9000`  puerto 9000.
-->
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://bie1:9000</value>
  </property>

</configuration>
```

📄 `/home/hadoop/hadoop/etc/hadoop/hdfs-site.xml` en `namenode`

```xml
<!--
  more configuration property
  https://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml

  nota:
  al modificar este archivo se puede configurar en caliente
  hdfs dfsadmin -reconfig namenode bie1:9000 start
-->
<configuration>
<!--
  dfs.namenode.name.dir
  file://${hadoop.tmp.dir}/dfs/name
  Determines where on the local filesystem the DFS name node should store the name table(fsimage). If this is a comma-delimited list of directories then the name table is replicated in all of the directories, for redundancy.
  - - - - - - - - - - - - - - - - - - - - - - - -
  Ruta donde esta guarda la table de direcciones de namenode
-->
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>/home/hadoop/discogrande/namenode</value>
  </property>
<!--
  dfs.replication
  default 3
  Default block replication. The actual number of replications can be specified when the file is created. The default is used if replication is not specified in create time.
  - - - - - - - - - - - - - - - - - - - - - - - -
  Cuando guardas un archivo en Hadoop, el archivo se divide en fragmentos de datos llamados "bloques" , pore defecto (128 MB). estos bloques se guardan en n nodos siendo n el valor de dfs.replication, en este caso como el valor es 2 se guarda cada "bloque" en 2 nodos.
-->
  <property>
    <name>dfs.replication</name>
    <value>2</value>
  </property>
<!--
  dfs.heartbeat.interval
  default 3
  Determines datanode heartbeat interval in seconds.
  - - - - - - - - - -
  tiempo que tarde en mili-segundos en dar un latido
-->
  <property>
    <name>dfs.heartbeat.interval</name>
    <value>1</value>
  </property>
<!--
  dfs.namenode.heartbeat.recheck-interval
  default 	300000
  300000	This time decides the interval to check for expired datanodes. With this value and dfs.heartbeat.interval, the interval of deciding the datanode is stale or not is also calculated. The unit of this configuration is millisecond.
  - - - - - - - - - - - - - - - - - - - - - - - -
  En el proceso de declarar un nodo como muerto
  tras no responder un nodo tras 10 latidos
  hadoop establece w periodos de gracia
  tiempo en mili-segundos de cada periodo de gracia :
-->
  <property>
    <name>dfs.namenode.heartbeat.recheck-interval</name>
    <value>500</value>
  </property>
<!--
  dfs.hosts
  Names a file that contains a list of hosts that are permitted to connect to the namenode. The full pathname of the file must be specified. If the value is empty, all hosts are permitted.
  - - - - - - - - - - - - - - - - - - - - - - - -
  En el proceso de declarar un nodo como muerto
  tras no responder un nodo tras 10 latidos
  hadoop establece w periodos de gracia
  tiempo en mili-segundos de cada periodo de gracia :
-->
   <property>
    <name>dfs.hosts</name>
    <value>/home/hadoop/hadoop/etc/hadoop/workers</value>
  </property>

</configuration>
```

📄 `nano /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml` en `datanode`

```xml
<configuration>

  <property>
    <name>dfs.datanode.data.dir</name>
    <value>/home/hadoop/discogrande/datanode</value>
  </property>

</configuration>
```

📄 `/home/hadoop/hadoop/etc/hadoop/workers`

> Cuando se ejecutan tareas de procesamiento de datos en un clúster de Hadoop, el framework Hadoop consulta este archivo para determinar qué nodos están disponibles para realizar el trabajo.

```bash
# default localhost
bie2
bie3
bie4
```

📄`/home/hadoop/hadoop/sbin/`

```bash
# ejecutables
distribute-exclude.sh httpfs.sh start-all.cmd start-dfs.sh stop-all.cmd stop-dfs.sh workers.sh
FederationStateStore kms.sh start-all.sh start-secure-dns.sh stop-all.sh stop-secure-dns.sh yarn-daemon.sh
hadoop-daemon.sh mr-jobhistory-daemon.sh start-balancer.sh start-yarn.cmd stop-balancer.sh stop-yarn.cmd yarn-daemons.sh
hadoop-daemons.sh refresh-namenodes.sh start-dfs.cmd start-yarn.sh stop-dfs.cmd stop-yarn.sh
```

### hadoop - comandos

#### configuración previa hadoop

##### install java

```bash
# install java 8
sudo apt install openjdk-8-jdk
# detectamos ruta de instalación --> /usr/lib/jvm/java-8-openjdk-amd64
# update-alternatives: utilizando [/usr/lib/jvm/java-8-openjdk-amd64]/bin/jconsole
```

##### install hadoop

```bash
# instalar hadoop
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
## descomprimir
tar -xzf hadoop-3.3.6.tar.gz
ls -la
## acortar nombre y ruta
mv hadoop-3.3.6 hadoop
# copiar carpeta hadoop a los otros nodos
scp -r /home/hadoop/hadoop hadoop@bie2:/home/hadoop

```

##### conf environment

```bash
# configurar entorno
sudo nano /etc/environment
# añadir al PATH binarios de hadoop
PATH="[...]:/home/hadoop/hadoop/bin:/home/hadoop/hadoop/sbin"
# añadir variable de entorno HADOOP_HOME
HADOOP_HOME="/home/hadoop/hadoop"
# añadir variable de entorno JAVA_HOME
JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# en un solo comando
sudo sh -c 'echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment';
sudo sh -c 'echo "HADOOP_HOME=/home/hadoop/hadoop" >> /etc/environment';
sudo sh -c 'echo "PATH=$PATH:/home/hadoop/hadoop/bin:/home/hadoop/hadoop/sbin" >> /etc/environment'
# verificar
cat /etc/environment | grep "JAVA_HOME";
# verificar instalación java
java -version
echo $JAVA_HOME; # necesario reboot
cat /etc/environment | grep hadoop
echo $HADOOP_HOME # necesario reboot

```

#### configuración básica hadoop core-site.xml

```bash
#=======================#
# editamos core-site.xml
#=======================#
# editamos core-site.xml
nano /home/hadoop/hadoop/etc/hadoop/core-site.xml
# no necesitamos permisos de administrador
ls -la /home/hadoop/hadoop/etc/hadoop/core-site.xml
#-rw-r--r-- 1 hadoop hadoop 869 feb 17 20:09 /home/hadoop/hadoop/etc/hadoop/core-site.xml
# añadimos entre <configuration> </configuration>
# <property>
#    <name>fs.defaultFS</name>
#    <value>hdfs://bie1:9000</value>
#  </property>

# en un solo comando
# borramos <configuration> </configuration>
sudo sed -i '/<configuration>/d' /home/hadoop/hadoop/etc/hadoop/core-site.xml
&& sudo sed -i '/<\/configuration>/d' /home/hadoop/hadoop/etc/hadoop/core-site.xml
&& sudo bash -c 'echo "<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://bie1:9000</value>
  </property>
</configuration>" >> /home/hadoop/hadoop/etc/hadoop/core-site.xml'

# core-site.xml se mantiene igual en todos los nodos con lo cual podemos copiarlo
scp /home/hadoop/hadoop/etc/hadoop/core-site.xml hadoop@bie2:/home/hadoop/hadoop/etc/hadoop/core-site.xml;
scp /home/hadoop/hadoop/etc/hadoop/core-site.xml hadoop@bie3:/home/hadoop/hadoop/etc/hadoop/core-site.xml;
scp /home/hadoop/hadoop/etc/hadoop/core-site.xml hadoop@bie4:/home/hadoop/hadoop/etc/hadoop/core-site.xml;
```

#### configuración básica hadoop hdfs-site.xml `namenode`

```bash
# creo namenode en nodo1
mkdir ~/discogrande/namenode

# no necesitamos permisos de administrador
hadoop@bie1:~$ ls -la /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml
#-rw-r--r-- 1 hadoop hadoop 979 feb 17 19:04 /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml

# configuramos namenode
# editamos hdfs-site.xml [nodo1]
nano /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml
# añadimos entre <configuration> </configuration>
#  <property>
#    <name>dfs.namenode.name.dir</name>
#    <value>/home/hadoop/discogrande/namenode</value>
#  </property>
#
#  <property>
#    <name>dfs.replication</name>
#    <value>2</value>
#  </property>
```

#### configuración básica hadoop hdfs-site.xml `datanode`

```bash
# creo en nodo2,3,4 datanode
mkdir ~/discogrande/datanode

# configuramos datanode
# editamos hdfs-site.xml [nodo2,3,4]
nano /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml
# añadimos nodo2 entre <configuration> </configuration>
# <property>
#    <name>dfs.datanode.data.dir</name>
#    <value>/home/hadoop/discogrande/datanode</value>
# </property>
# copiamos en nodo3 y nodo4
scp /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml hadoop@bie3:/home/hadoop/hadoop/etc/hadoop/hdfs-site.xml
scp /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml hadoop@bie4:/home/hadoop/hadoop/etc/hadoop/hdfs-site.xml

# verificar que nos muestra la info entre <configuration> </configuration>
echo "[📄 /home/hadoop/hadoop/etc/hadoop/core-site.xml]";
sed -n '/<configuration>/,/<\/configuration>/p' /home/hadoop/hadoop/etc/hadoop/core-site.xml;
echo "[📄 /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml]";
sed -n '/<configuration>/,/<\/configuration>/p' /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml;
```

#### configuración fina

ver configuración

[web - http://192.168.0.101:9870/](http://192.168.0.101:9870/)

#### hadoop acciones

```bash
# formatear namenode
hdfs namenode -form
# ver procesos java activos
jps
# ver
hdfs dfsadmin -report
# modificar en caliente hadoop/workers
hdfs dfsadmin -refreshNodes
# volver a leer la configuración de en caliente
hdfs dfsadmin -reconfig namenode bie1:9000 start

# iniciar namenode
hdfs --daemon start namenode
# iniciar datanode
hdfs --daemon start datanode

# consultar valores de configuración
# nota : hdfs getconf -confKey propiedad que queremos consultar
echo "tabla namenode guardad en la ruta"
hdfs getconf -confKey dfs.namenode.name.dir;
echo "cantidad de replicas que se mantienen"
hdfs getconf -confKey dfs.replication;
echo "frecuencia de latidos en segundos"
hdfs getconf -confKey dfs.heartbeat.interval;
echo "tiempo de espera de los dos periodos de gracia en mili-segundos"
hdfs getconf -confKey dfs.namenode.heartbeat.recheck-interval;
hdfs getconf -confKey dfs.hosts;
echo "hay que tener en cuenta :"
echo "para que hadoop declare un nodo muerto:";
echo -e "\t 1.- tiene que pasar  un nodo sin responder 10 latidos de [dfs.heartbeat.interval] (3 x defecto) segundos ";
echo -e "\t 2.- dos periodos de gracia de [dfs.namenode.heartbeat.recheck-interval] (5 min default) cada uno";
echo "esto ocurre para asegurarse plenamente de que el nodo no es funcional antes de que se muevan cantidades muy grandes de información implicando la saturación de recursos ";

```

#### hadoop salida de comandos

salida de `hdfs dfsadmin -report`

```txt

Configured Capacity: 315264577536 (293.61 GB)
Present Capacity: 299108155392 (278.57 GB)
DFS Remaining: 299108081664 (278.57 GB)
DFS Used: 73728 (72 KB)
DFS Used%: 0.00%
Replicated Blocks:
        Under replicated blocks: 0
        Blocks with corrupt replicas: 0
        Missing blocks: 0
        Missing blocks (with replication factor 1): 0
        Low redundancy blocks with highest priority to recover: 0
        Pending deletion blocks: 0
Erasure Coded Block Groups:
        Low redundancy block groups: 0
        Block groups with corrupt internal blocks: 0
        Missing block groups: 0
        Low redundancy blocks with highest priority to recover: 0
        Pending deletion blocks: 0

-------------------------------------------------
Live datanodes (3):

Name: 192.168.0.102:9866 (bie2)
Hostname: bie2
Decommission Status : Normal
Configured Capacity: 105088192512 (97.87 GB)
DFS Used: 24576 (24 KB)
Non DFS Used: 45056 (44 KB)
DFS Remaining: 99702693888 (92.86 GB)
DFS Used%: 0.00%
DFS Remaining%: 94.88%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 0
Last contact: Sat Feb 17 20:22:26 UTC 2024
Last Block Report: Sat Feb 17 20:19:59 UTC 2024
Num of Blocks: 0


Name: 192.168.0.103:9866 (bie3)
Hostname: bie3
Decommission Status : Normal
Configured Capacity: 105088192512 (97.87 GB)
DFS Used: 24576 (24 KB)
Non DFS Used: 45056 (44 KB)
DFS Remaining: 99702693888 (92.86 GB)
DFS Used%: 0.00%
DFS Remaining%: 94.88%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 0
Last contact: Sat Feb 17 20:22:25 UTC 2024
Last Block Report: Sat Feb 17 20:19:34 UTC 2024
Num of Blocks: 0


Name: 192.168.0.104:9866 (bie4)
Hostname: bie4
Decommission Status : Normal
Configured Capacity: 105088192512 (97.87 GB)
DFS Used: 24576 (24 KB)
Non DFS Used: 45056 (44 KB)
DFS Remaining: 99702693888 (92.86 GB)
DFS Used%: 0.00%
DFS Remaining%: 94.88%
Configured Cache Capacity: 0 (0 B)
Cache Used: 0 (0 B)
Cache Remaining: 0 (0 B)
Cache Used%: 100.00%
Cache Remaining%: 0.00%
Xceivers: 0
Last contact: Sat Feb 17 20:22:25 UTC 2024
Last Block Report: Sat Feb 17 20:20:10 UTC 2024
Num of Blocks: 0
```

<!-- pagebreak -->

📄 env-start.sh

![env-start.sh](env-start.sh)

<!-- pagebreak -->

📄 env-stop.sh

![env-stop.sh](env-stop.sh)
