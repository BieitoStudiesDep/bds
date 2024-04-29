
#### openssh

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