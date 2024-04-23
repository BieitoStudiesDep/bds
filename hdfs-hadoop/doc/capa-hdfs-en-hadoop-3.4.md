---
tags:
						  - ceia-bdsadoop-template
type: video
issue: hdfs-hadoop
concept: capa-hdfs-en-hadoop-3.4
---
![Capa-HDFS-en-Hadoop-3.4](https://youtu.be/5Mp164m1__Q?si=mORqT6rNwYBbbsTf)

#### entorno
|mv-name|hdfs|ip|-|
|-|-|-|-|
|hadoop-template|-|192.168.0.100|-|
|hadoop-nodo01|namenode|192.168.0.101|-|
|hadoop-nodo02|datanode|192.168.0.102|-|
|hadoop-nodo03|datanode|192.168.0.103|-|
|hadoop-nodo04|datanode|192.168.0.104|-|

|hardware|value|
|-|-|
|ram|2048MB|
|procesadores|2|
|internal-disk|100G|
|data-disk|500G|
				

|user|password|
|-|-|
|hdfs-admin|abc123.|

```bash
# install guest additions
sudo apt-get install gcc make perl
```

```bash
ssh hdfs-admin@192.168.0.100
ssh hdfs-admin@192.168.0.101
ssh hdfs-admin@192.168.0.102
ssh hdfs-admin@192.168.0.103
ssh hdfs-admin@192.168.0.104
```
#### 1.- add static IP

```bash
# configurar ips
sudo nano /etc/netplan/01-network-manager-all.yaml
sudo netplan try
```

📁`/etc/netplan/01-network-manager-all.yaml` 

```
sudo nano /etc/hostname
```

```bash
# configurar ips
sudo nano /etc/hostname
```

#### 2.- add  hostname

📁`/etc/hostname` 

```bash
# nodoXX
nodo01
# nodo02
# nodo03
```

#### 3.- add  hostname

📁`/etc/hosts` 

```bash
127.0.0.1      localhost

192.168.0.101  nodo01
192.168.0.102  nodo02
192.168.0.103  nodo03
192.168.0.104  nodo04
```


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
```bash
sudo apt install openssh-server

sudo nano /etc/ssh/sshd_config
# descomentar
# Port 22
# ListenAddress 0.0.0.0

# reinicio el servicio
sudo systemctl restart ssh
sudo systemctl status ssh

# generar pareja de llaves

ssh-keygen
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo-template ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo01 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo02 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo03 ; ls -la .ssh/
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo04 ; ls -la .ssh/
ls -la .ssh/
```

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

[minuto 8:00](https://www.youtube.com/watch?v=5Mp164m1__Q&t=8m

#### 6.- Configuración ssh claves publicas

```bash title:"<font style="color:yellow">⚠️</font> Si da problemas" fold wrap
# si da problemas
## nodo-template
rm -rf .ssh/authorized_keys;
rm -rf .ssh/nodo-template.pub;
rm -rf .ssh/nodo-template;
rm -rf .ssh/known_hosts;
rm -rf .ssh/authorized_keys_old;
rm -rf .ssh/known_hosts.old;
ls -la .ssh/;
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo-template ; ls -la .ssh/
sudo systemctl restart sshd # resetear servicio

## nodo01
rm -rf .ssh/authorized_keys;
rm -rf .ssh/nodo01.pub;
rm -rf .ssh/nodo01;
rm -rf .ssh/known_hosts;
rm -rf .ssh/authorized_keys_old;
rm -rf .ssh/known_hosts.old;
ls -la .ssh/;
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo01 ; ls -la .ssh/
sudo systemctl restart sshd # resetear servicio

## nodo02
rm -rf .ssh/authorized_keys;
rm -rf .ssh/nodo02.pub;
rm -rf .ssh/nodo02;
rm -rf .ssh/known_hosts;
rm -rf .ssh/authorized_keys_old;
rm -rf .ssh/known_hosts.old;
ls -la .ssh/;
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo02 ; ls -la .ssh/
sudo systemctl restart sshd # resetear servicio

## nodo03
rm -rf .ssh/authorized_keys;
rm -rf .ssh/nodo03.pub;
rm -rf .ssh/nodo03;
rm -rf .ssh/known_hosts;
rm -rf .ssh/authorized_keys_old;
rm -rf .ssh/known_hosts.old;
ls -la .ssh/;
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo03 ; ls -la .ssh/
sudo systemctl restart sshd # resetear servicio

## nodo04
rm -rf .ssh/authorized_keys;
rm -rf .ssh/nodo04.pub;
rm -rf .ssh/nodo04;
rm -rf .ssh/known_hosts;
rm -rf .ssh/authorized_keys_old;
rm -rf .ssh/known_hosts.old;
ls -la .ssh/;
ssh-keygen -t rsa -f /home/hdfs-admin/.ssh/nodo04 ; ls -la .ssh/
sudo systemctl restart sshd # resetear servicio
```

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

📂
>[!my-folder]-  sshd_config
>`sudo nano /etc/ssh/sshd_config`
>```bash
>[...]
>Port 22  
>ListenAddress 0.0.0.0
>PubkeyAuthentication yes
>[...]
>```

>[!my-comment]-  comentario
>comentariooooooooooooo

>[!Tip]-  Resetear servicio ssh
>`sudo systemctl restart sshd`
#### 7.- Montar disco de datos

```bash wrap
# ver dispositivos
lsblk

# particionar
sudo fdisk /dev/vdb
# p ==> ver info
# g ==> tabla de particiones gpt
# n ==> nueva particion [enter] , valores por defecto
# w ==> escribir cambios

# dar formato
sudo mkfs.ext4 /dev/sdb1

# crear carpeta de montaje
mkdir discogrande

# persistencia 
sudo nano /etc/fstab
# añadimos
# ruta disco | ruta de montaje | sist. ficheros | opciones | que se compruebe|orden de comprobación
# /dev/sdb1   /home/hdfs-admin/discogrande ext4  defaults 0 0

sudo reboot # reiniciamos para que se monte el disco
lsblk # en el ultimo parametro nos indica en que ruta esta montado el disco

```

|ruta de disco|ruta de montaje|sistema de ficheros|opciones de lectura / escritura|que se compruebe|orden de comprobación|
|:-:|:-:|:-:|:-:|:-:|:-:|
|/dev/sdb1|/home/hdfs-admin/discogrande|ext4|defaults|0|0|-|-|

```bash title:"lsblk ouput" fold wrap
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0    7:0    0     4K  1 loop /snap/bare/5
loop1    7:1    0 266,6M  1 loop /snap/firefox/3836
loop2    7:2    0  74,2M  1 loop /snap/core22/1122
loop3    7:3    0   497M  1 loop /snap/gnome-42-2204/141
loop4    7:4    0  91,7M  1 loop /snap/gtk-common-themes/1535
loop5    7:5    0  12,3M  1 loop /snap/snap-store/959
loop6    7:6    0  40,4M  1 loop /snap/snapd/20671
loop7    7:7    0   452K  1 loop /snap/snapd-desktop-integration/83
sda      8:0    0   100G  0 disk 
├─sda1   8:1    0     1M  0 part 
├─sda2   8:2    0   513M  0 part /boot/efi
└─sda3   8:3    0  99,5G  0 part /var/snap/firefox/common/host-hunspell
                                 /
sdb      8:16   0   500G  0 disk 
└─sdb1   8:17   0   500G  0 part /home/hdfs-admin/discogrande
sr0     11:0    1  1024M  0 rom  
```

```bash
# verificar entorno
env | grep "hadoop";
env | grep "java";
lsblk | grep "discogrande";


```