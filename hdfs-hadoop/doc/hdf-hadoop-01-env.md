# hdf-hadoop  Entorno

#### Entorno
>[!Info]- hdf-hadoop  Entorno
> [[#1.- add static IP|1. configurado la dirección IP fija de cada uno de los nodos]]
> 2. cambiado el nombre del nodo
> 3. hemos incluido en su archivo Host las ips los nombres del resto de los nodos 
> 4. instalado Java en su versión 8 
>	- además hemos creado una variable de sistema que se llama Java home a la que le hemos dado la ruta de este Java versión 8
>	- lo hemos hecho en el archivo `/etc/environment`
>	- porque esto nos permite que esta variable esté disponible Incluso si no hemos iniciado sesión Dentro de este equipo solamente lo hemos encendido
> 5. instalado el servidor ssh
>	- pienso que no sería necesario pero hemos des-comentar las líneas del puerto y de las ips aceptadas hemos reiniciado el servicio hemos generado las claves públicas y privadas y las hemos compartido entre todos los equipos incluido el local Host después hemos 
> 6. descargado hadoop lo hemos descomprimido y lo hemos dejado en una carpeta con un nombre amigable porque lo vamos a usar mucho después de esto hemos vuelto al archivo /etc/environment para Añadir un par de cosas en primer lugar 
>	- hemos añadido al pth las rutas de la carpeta Bin y sbin de hadoop para hacer accesibles todos sus comandos desde cualquier punto del sistema 
>	- hemos añadido una nueva variable global llamada hado home en la que hemos puesto la ruta base donde están los archivos de hadoop 
> 7. por último he configurado ese segundo disco duro que teníamos
>	- para que siempre en cada arranque se monte en una carpeta que se llama disc grande cuando configure hado le indicaré que deje sus archivos dentro de esta carpeta en principio con esto acabamos la parte de



#### 1.- add static IP

```bash
# configurar ips
sudo nano /etc/netplan/01-network-manager-all.yaml
sudo netplan try
```

>[!my-folder]-  01-network-manager-all.yaml
>`sudo nano /etc/netplan/01-network-manager-all.yaml`
> con `ip a` detectamos la interfaz de red `enp0s3`
> definimos
>
> - una ip estatica `192.168.0.101/24`
> - una puerta de enlace `192.168.0.1`
> - unos dns `192.168.0.1` y `8.8.8.8`
>
>```bash
># Let NetworkManager manage all devices on this system
>network:
>  version: 2
>  ethernets:
>     enp0s3:
>       addresses:
>        - 192.168.0.101/24
>       routes:
>       - to: default
>         via: 192.168.0.1
>       nameservers:
>        addresses:
>          - 192.168.0.1
>          - 8.8.8.8
>```

#### 2.- add  hostname

>[!my-folder]- hostname
>📁`/etc/hostname`
> definir el nombre del equipo
>
>```bash
># nodoXX
>nodo01
># nodo02
># nodo03
># nodo04
>```

#### 3.- edit hosts

>[!my-folder]- hosts
>📁`/etc/hosts`
>
> - definir el nombre y la ruta de otros equipos
> - similar a un DNS pero a nivel local
>
>```bash
>127.0.0.1      localhost
>
>192.168.0.101  nodo01
>192.168.0.102  nodo02
>192.168.0.103  nodo03
>192.168.0.104  nodo04
>```

#### 3.- install java08

```bash
sudo apt update && sudo apt upgrade
sudo apt install openjdk-8-jdk
# en la salida del comando 
# ver la ruta del sistema de los binarios de java
# update-alternatives: ____
sudo nano /etc/environment
# PATH= [..]
# JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# comprobar variables del sistema 
env
```

#### 4.- install openssh

##### 4.0- openssh
>
>>[!my-folder]-  archivos
>> ~/.ssh/
>> ==├── authorized_keys==
>> ==├── known_hosts==
>> ├── known_hosts.old
>> ==├── nodo01== # custom clave privada # default id_rsa
>> ==└── nodo01.pub== # custom clave publica # default id_rsa.pub
>>
>> /etc/ssh/
>> ├── moduli
>> ==── ssh_config==
>> ├── ssh_config.d
>> ==── sshd_config==
>> ├── sshd_config.d
>> ├── ssh_host_ecdsa_key
>> ├── ssh_host_ecdsa_key.pub
>> ├── ssh_host_ed25519_key
>> ├── ssh_host_ed25519_key.pub
>> ├── ssh_host_rsa_key
>> ├── ssh_host_rsa_key.pub
>> └── ssh_import_id
>>
>> | archivo | dirección |uso| descripción|
>> |:-:|:-:|-|-|
>> |sshd_config| sudo nano /etc/ssh/sshd_config  | archivo de configuration de usuario del servicio ssh | lo usaremos para indentificar el nombre de una clave publica/privada cuando queramos ponerle un nombre custom y no el por defecto ` id_rsa``|
>> |ssh_config| sudo nano /etc/ssh/ssh_config | archivo de configuration de servidor del servicio ssh| lo usaremos para indicar el puerto y permitir todas las conexiones|
>
>>[!my-terminal]-  comandos
>>
>> | comando | descripción |
>> |-|-|
>> |ssh-copy-id -i .ssh/nodo-01.pub hdfs-admin@nodo02| copia la clave publica del nodo01 en el `authorized_keys` del nodo02  <br> objetivo crear un conexión > ssh autentificada por clave publica sin necesidad de pedir contraseña al usuario|
>> |ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo01 | generar <br>clave publica <br>  - `nodo01.pub` <br>  - x defecto `id_rsa.pub` <br> privada <br>  -  `nodo01` <br>  - x defecto `id_rsa` |
>> |sudo systemctl restart ssh | reiniciar servicio ssh |
>> |sudo systemctl status ssh | ver estado de  servicio ssh |
>> |sudo systemctl restart sshd | reiniciar servicio sshd |
>> |ls -la .ssh/| lista clave publica (.pub) y privada|
>

##### 4.1- install openssh

```bash
sudo apt install openssh-server

sudo nano /etc/ssh/sshd_config
# descomentar
# Port 22
# ListenAddress 0.0.0.0

# reinicio el servicio
sudo systemctl restart ssh
sudo systemctl status ssh
sudo systemctl status sshd
```

##### 4.2- generar claves publica/privada

`ssh-keygen`

```bash
# generar pareja de llaves
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo-template ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo01 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo02 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo03 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo04 ; ls -la .ssh/
ls -la .ssh/
```

##### 4.2- configurar cliente ==⚠ solo si las claves tienen un nombre custom==
>
>[!Warning]- solo necesario si la clave publica tiene un nombre custom != id_rsa

>[!my-folder]-  ssh_config
>`sudo nano /etc/ssh/ssh_config`
>Si la claves generadas tienen un nombre custom
>debemos idntificarlas en el archivo `ssh_config`
> mediante
>
> - `IdentityFile ~/.ssh/nodo1`
>
>```bash
>[...]
>IdentityFile ~/.ssh/nodo1  
>[...]
>```
>
📄 sudo cat /etc/ssh/ssh_config --> configuración Cliente
  
```bash
sudo nano /etc/ssh/ssh_config
# IdentityFile ~/.ssh/nodo1 # escribir al final del archivo

## un solo comando
sudo bash -c 'echo "IdentityFile ~/.ssh/nodo01" >> /etc/ssh/ssh_config'
sudo bash -c 'echo "IdentityFile ~/.ssh/nodo02" >> /etc/ssh/ssh_config'
sudo bash -c 'echo "IdentityFile ~/.ssh/nodo03" >> /etc/ssh/ssh_config'
sudo bash -c 'echo "IdentityFile ~/.ssh/nodo04" >> /etc/ssh/ssh_config'

sudo systemctl restart ssh && sudo systemctl restart sshd # resetear servicio

## verificar
cat /etc/ssh/ssh_config | grep "IdentityFile"
```

##### 4.3- generar claves publica/privada

```bash
# desde nodo-template 
ssh-copy-id -i .ssh/nodo-template.pub hdfs-admin@nodo-template;
ssh-copy-id -i .ssh/nodo-template.pub hdfs-admin@nodo01;
ssh-copy-id -i .ssh/nodo-template.pub hdfs-admin@nodo02;
ssh-copy-id -i .ssh/nodo-template.pub hdfs-admin@nodo03;
ssh-copy-id -i .ssh/nodo-template.pub hdfs-admin@nodo04;

# desde nodo01 
ssh-copy-id -i .ssh/nodo01.pub hdfs-admin@nodo-template;
ssh-copy-id -i .ssh/nodo01.pub hdfs-admin@nodo01;
ssh-copy-id -i .ssh/nodo01.pub hdfs-admin@nodo02;
ssh-copy-id -i .ssh/nodo01.pub hdfs-admin@nodo03;
ssh-copy-id -i .ssh/nodo01.pub hdfs-admin@nodo04;

# desde nodo02
ssh-copy-id -i .ssh/nodo02.pub hdfs-admin@nodo-template;
ssh-copy-id -i .ssh/nodo02.pub hdfs-admin@nodo01;
ssh-copy-id -i .ssh/nodo02.pub hdfs-admin@nodo02;
ssh-copy-id -i .ssh/nodo02.pub hdfs-admin@nodo03;
ssh-copy-id -i .ssh/nodo02.pub hdfs-admin@nodo04;

# desde nodo03
ssh-copy-id -i .ssh/nodo03.pub hdfs-admin@nodo-template;
ssh-copy-id -i .ssh/nodo03.pub hdfs-admin@nodo01;
ssh-copy-id -i .ssh/nodo03.pub hdfs-admin@nodo02;
ssh-copy-id -i .ssh/nodo03.pub hdfs-admin@nodo03;
ssh-copy-id -i .ssh/nodo03.pub hdfs-admin@nodo04;

# desde nodo04
ssh-copy-id -i .ssh/nodo04.pub hdfs-admin@nodo-template;
ssh-copy-id -i .ssh/nodo04.pub hdfs-admin@nodo01;
ssh-copy-id -i .ssh/nodo04.pub hdfs-admin@nodo02;
ssh-copy-id -i .ssh/nodo04.pub hdfs-admin@nodo03;
ssh-copy-id -i .ssh/nodo04.pub hdfs-admin@nodo04;
```

>[!my-folder]-  sshd_config
>`sudo nano /etc/ssh/sshd_config`
>
>```bash
>[...]
>Port 22  
>ListenAddress 0.0.0.0
>PubkeyAuthentication yes
>[...]
>```

>[!Tip]-  Resetear servicio ssh
>`sudo systemctl restart sshd`
>`sudo systemctl restart ssh`
>
#### 5.- install hadoop 3.4.0

```bash
cd ~ 
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz
ls -la

# descomprimir
tar -xzf hadoop-3.4.0.tar.gz
ls -la
rm -rf hadoop-3.4.0.tar.gz

# renombrar a hadoop
mv hadoop-3.4.0 hadoop
ls -la

# ruta de archivos de configuración
ls ~/hadoop/etc/hadoop/
# ruta de archivos de binarios
ls ~/hadoop/bin
ls ~/hadoop/sbin

# añadir al PATH los binarios de hadoop
sudo nano /etc/environment
# PATH= [..]:/home/admin/hadoop/bin:/home/admin/hadoop/sbin
# HADOOP_HOME="/home/admin/hadoop/"

# reinicio
sudo reboot
env
```

📁sudo nano /etc/environment

```bash
# PATH= [..]:/home/hdfs-admin/hadoop/bin:/home/hdfs-admin/hadoop/sbin
# JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# HADOOP_HOME="/home/hdfs-admin/hadoop"
```

[minuto 8:00](<https://www.youtube.com/watch?v=5Mp164m1__Q&t=8m>

#### 6.- Montar disco de datos
>
>>[!my-terminal]-  comandos
>>
>>```bash wrap
>># ver dispositivos
>>lsblk
>>
>># particionar
>>sudo fdisk /dev/vdb
>># p ==> ver info
>># g ==> tabla de particiones gpt
>># n ==> nueva particion [enter] , valores por defecto
>># w ==> escribir cambios
>>
>># dar formato
>>sudo mkfs.ext4 /dev/sdb1
>>
>># crear carpeta de montaje
>>mkdir discogrande
>>
>># persistencia 
>>sudo nano /etc/fstab
>># añadimos
>># ruta disco | ruta de montaje | sist. ficheros | opciones | que se compruebe|orden de comprobación
>># /dev/sdb1   /home/hdfs-admin/discogrande ext4  defaults 0 0
>>
>>sudo reboot # reiniciamos para que se monte el disco
>>lsblk # en el ultimo parametro nos indica en que ruta esta montado el disco
>>
>>```
>
>>[!my-folder]-  fstab
>>`sudo nano /etc/fstab`
>>
>> - Persistencia del montage de disco
>> - Al iniciar el equipo se monta el disco de manera automatizada
>>
>> |ruta de disco|ruta de montaje|sistema de ficheros|opciones de lectura / escritura|que se compruebe|orden de comprobación|
>> |:-:|:-:|:-:|:-:|:-:|:-:|
>> |/dev/sdb1|/home/hdfs-admin/discogrande|ext4|defaults|0|0|-|-|
>
>>```bash title:"lsblk ouput" fold wrap
>>NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
>>loop0    7:0    0     4K  1 loop /snap/bare/5
>>loop1    7:1    0 266,6M  1 loop /snap/firefox/3836
>>loop2    7:2    0  74,2M  1 loop /snap/core22/1122
>>loop3    7:3    0   497M  1 loop /snap/gnome-42-2204/141
>>loop4    7:4    0  91,7M  1 loop /snap/gtk-common-themes/1535
>>loop5    7:5    0  12,3M  1 loop /snap/snap-store/959
>>loop6    7:6    0  40,4M  1 loop /snap/snapd/20671
>>loop7    7:7    0   452K  1 loop /snap/snapd-desktop-integration/83
>>sda      8:0    0   100G  0 disk 
>>├─sda1   8:1    0     1M  0 part 
>>├─sda2   8:2    0   513M  0 part /boot/efi
>>└─sda3   8:3    0  99,5G  0 part /var/snap/firefox/common/host-hunspell
>>                                 /
>>sdb      8:16   0   500G  0 disk 
>>└─sdb1   8:17   0   500G  0 part /home/hdfs-admin/discogrande
>>sr0     11:0    1  1024M  0 rom  
>>```

#### 7.- verificar entorno

```bash
# verificar entorno
env | grep "hadoop";
env | grep "java";
lsblk | grep "discogrande";
# verificar /etc/ssh/ssh_config
cat /etc/ssh/ssh_config | grep "IdentityFile"
# verificar /etc/ssh/sshd_config
# [output] ==> Port 22 ListenAddress 0.0.0.0 PubkeyAuthentication yes
sudo cat /etc/ssh/sshd_config | grep -E "PubkeyAuthentication|Include|Port|ListenAddress"
```
