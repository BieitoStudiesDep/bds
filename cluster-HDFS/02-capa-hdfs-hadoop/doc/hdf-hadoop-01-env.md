# hdf-hadoop  Entorno

#### Entorno
>[!Info]- hdf-hadoop  Entorno
> [[#1.- Necesitamos que los nodos tengan una IP estática|1. configurado la dirección IP fija de cada uno de los nodos]]
> 
> [[#2.- Necesitamos definir un nombre amigable en cada nodo|2. cambiado el nombre del nodo]]
> 
> [[#3.- Necesitamos conocer el nombre y la ip de los demas nodos|3. hemos incluido en su archivo Host las ips los nombres del resto de los nodos]] 
>
> [[#4.- el entorno de hadoop funciona con java|4. instalado Java en su versión 8 ]]
> - además hemos creado una variable de sistema que se llama Java home a la que le hemos dado la ruta de este Java versión 8
> - lo hemos hecho en el archivo `/etc/environment`
> - porque esto nos permite que esta variable esté disponible Incluso si no hemos iniciado sesión Dentro de este equipo solamente lo hemos encendido
>
> [[#5.- Hadoop necesita comunicarse via ssh entre los nodos sin necesidad de acreditarse mediante contraseña|5. instalado el servidor ssh]]
> - pienso que no sería necesario pero hemos des-comentar las líneas del puerto y de las ips aceptadas hemos reiniciado el servicio
> - hemos generado las claves públicas y privadas y las hemos compartido entre todos los equipos incluido el local Host después hemos 
>
>[[#6.- Necesitamos instalar Hadoop|6. descargado hadoop]]
> - lo hemos descomprimido y lo hemos dejado en una carpeta con un nombre amigable porque lo vamos a usar mucho después de esto hemos vuelto al archivo /etc/environment para Añadir un par de cosas
> - hemos añadido al pth las rutas de la carpeta Bin y sbin de hadoop para hacer accesibles todos sus comandos desde cualquier punto del sistema 
> - hemos añadido una nueva variable global llamada hado home en la que hemos puesto la ruta base donde están los archivos de hadoop 
> 
> [[#7.- Es recomendable designar un disco de datos|7. por último he configurado ese segundo disco duro que teníamos]]
> - para que siempre en cada arranque se monte en una carpeta que se llama disc grande cuando configure hado le indicaré que deje sus archivos dentro de esta carpeta 
> 
> [[#8.- verificar entorno]]



#### 1.- Necesitamos que los nodos tengan una IP estática
- configurado la dirección IP fija de cada uno de los nodos
![[ip-static#Add static IP]]

#### 2.- Necesitamos definir un nombre amigable en cada nodo
-  cambiado el nombre del nodo
![[etc-hostname#add hostname]]

#### 3.- Necesitamos conocer el nombre y la ip de los demas nodos
- incluir en su archivo Host las ips los nombres del resto de los nodos 
![[etc-hosts#edit hosts]]

#### 4.- el entorno de hadoop funciona con java
- instalado Java en su versión 8 
	- además hemos creado una variable de sistema que se llama Java home a la que le hemos dado la ruta de este Java versión 8
	- lo hemos hecho en el archivo `/etc/environment`
	- porque esto nos permite que esta variable esté disponible Incluso si no hemos iniciado sesión Dentro de este equipo solamente lo hemos encendido

![[install-java08#install java08]]

#### 5.- Hadoop necesita comunicarse via ssh entre los nodos sin necesidad de acreditarse mediante contraseña
- instalado el servidor ssh
	- pienso que no sería necesario pero hemos des-comentar las líneas del puerto y de las ips aceptadas hemos reiniciado el servicio
	- hemos generado las claves públicas y privadas y las hemos compartido entre todos los equipos incluido el local Host después hemos 

![[openssh#openssh]]

#### 6.- Necesitamos instalar Hadoop
- descargado hadoop lo hemos descomprimido y lo hemos dejado en una carpeta con un nombre amigable porque lo vamos a usar mucho después de esto hemos vuelto al archivo /etc/environment para Añadir un par de cosas en primer lugar 
	- hemos añadido al pth las rutas de la carpeta Bin y sbin de hadoop para hacer accesibles todos sus comandos desde cualquier punto del sistema 
	- hemos añadido una nueva variable global llamada hado home en la que hemos puesto la ruta base donde están los archivos de hadoop 

![[install-hadoop-3.4.0#install-hadoop-3.4.0]]

#### 7.- Es recomendable designar un disco de datos
 - he configurado ese segundo disco duro que teníamos
	- para que siempre en cada arranque se monte en una carpeta que se llama disc grande cuando configure hado le indicaré que deje sus archivos dentro de esta carpeta 
	
![[disk#6.- Montar disco de datos]]

#### 8.- verificar entorno

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
