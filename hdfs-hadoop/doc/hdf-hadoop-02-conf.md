
#### Config
>[!Info]- hdf-hadoop  Conf
> [[#1.- hadoop - identificar el nodo que actúa como principal hdfs-hadoop/archivos/core-site.xml core-site.xml]]
> 
> [[#2.- hadoop conf nodos hdfs-hadoop/archivos/hdfs-site.xml hdfs-site.xml]]
> 
>  - [[#2.1 hdfs-site.xml-namenode]]
>  - [[#2.2 hdfs-site.xml-datanode]]
> 
> [[#3.-establecer la tabla de particiones]]
> 
> [[#4.- levantar todos los nodos]]

hadoop trabaja en una estructura distribuida pero centralizada
hay un nod principal

```bash
ls ~/hadoop/etc/hadoop/core-site.xml
tree ~/hadoop/etc/hadoop/
```

>
>>[!my-folder]-  archivos
>>> [!my-tree]-  tree
>>>/home/hdfs-admin/hadoop/etc/hadoop/
>>> ==├── capacity-scheduler.xml== // identifica al nodo principal
>>> ==├── decomisados== // archivo que crearemos nostros
>>> ==├── hdfs-site.xml== // configuramos las propiedades de  [[nodo-datanode]] y [[nodo-namenode]]
>>> ==├── workers== //indicaremos los nombres de los [[nodo-datanode]]
>>> ├── configuration.xsl
>>> ├── container-executor.cfg
>>> ├── core-site.xml
>>> ├── hadoop-env.cmd
>>> ├── hadoop-env.sh
>>> ├── hadoop-metrics2.properties
>>> ├── hadoop-policy.xml
>>> ├── hadoop-user-functions.sh.example
>>> ├── hdfs-rbf-site.xml
>>> ├── httpfs-env.sh
>>> ├── httpfs-log4j.properties
>>> ├── httpfs-site.xml
>>> ├── kms-acls.xml
>>> ├── kms-env.sh
>>> ├── kms-log4j.properties
>>> ├── kms-site.xml
>>> ├── log4j.properties
>>> ├── mapred-env.cmd
>>> ├── mapred-env.sh
>>> ├── mapred-queues.xml.template
>>> ├── mapred-site.xml
>>> ├── shellprofile.d
>>> │   └── example.sh
>>> ├── ssl-client.xml.example
>>> ├── ssl-server.xml.example
>>> ├── user_ec_policies.xml.template
>>> ├── yarn-env.cmd
>>> ├── yarn-env.sh
>>> ├── yarnservice-log4j.properties
>>> └── yarn-site.xml
>>
>>> [!my-table]-  table
>>>
>>> | archivo | dirección |uso| descripción|
>>> |:-:|:-:|-|-|
>>> |capacity-scheduler.xml| sudo nano ~/hadoop/etc/hadoop/capacity-scheduler.xml  | indica que nodo actúa como nodo principal|
>>> |ssh_config| sudo nano /etc/ssh/ssh_config | archivo de configuration de servidor del servicio ssh| lo usaremos para indicar el puerto y permitir todas las conexiones|
>>
>>>[!my-terminal]-  comandos
>>>
>>> | comando | descripción |
>>> |-|-|
>>> |`hadoop conftest`| indica si los archivos de hadoop estan sintacticamente bien construidos en cuanto a sus etiquetas, no identifica los errores  del contenido de las mismas|
>>> |`scp ~/hadoop/etc/hadoop/core-site.xml nodo02:~/hadoop/etc/hadoop/`| copiar archivo de origen al nodo02 |
>>> |sudo systemctl restart ssh | reiniciar servicio ssh |
>>> |sudo systemctl status ssh | ver estado de  servicio ssh |
>>> |sudo systemctl restart sshd | reiniciar servicio sshd |
>>> |ls -la .ssh/| lista clave publica (.pub) y privada|
>>
>>>[!my-folder]- capacity-scheduler.xml
>>> identificar el `nodo01` como `nodo principal`
>>> replicarlo en todos los nodos
>>>> Todos los nodos deben saber cual es el nodo principal
>>>`sudo nano ~/hadoop/etc/hadoop/capacity-scheduler.xml`
>>>
>>>```bash
>>> <configuration>
>>> 	<property>
>>> 		<name>fs.defaultFS</name>
>>> 		<value>hdfs://nodo01:9000</value>
>>> 	</property>
>>> </configuration>
>>> ```
>>> >>
>>>[!my-folder]- hdfs-site.xml
>>> configurar el nodo01 como `nameNode`
>>>`sudo nano ~/hadoop/etc/hadoop/hdfs-site.xml`
>>>
>>>```bash
>>> <configuration>
>>> 	<property>
>>> 		<name>fs.defaultFS</name>
>>> 		<value>hdfs://nodo01:9000</value>
>>> 	</property>
>>> </configuration>
>>> ```

#### 1.- hadoop - identificar el nodo que actúa como principal [[hdfs-hadoop/archivos/core-site.xml|core-site.xml]]
- configuaracion identica para
	- namenodes
	- datanodes

![[hdfs-hadoop/archivos/core-site.xml|core-site.xml]]

```bash
sudo nano ~/hadoop/etc/hadoop/core-site.xml

## verificar etiquetas estan bien escritas en arch hadoop
hadoop conftest
## ouput 
# /home/hdfs-admin/hadoop/etc/hadoop/httpfs-site.xml: valid
# /home/hdfs-admin/hadoop/etc/hadoop/yarn-site.xml: valid  
# /home/hdfs-admin/hadoop/etc/hadoop/capacity-scheduler.xml: valid
# /home/hdfs-admin/hadoop/etc/hadoop/hdfs-rbf-site.xml: valid     
# /home/hdfs-admin/hadoop/etc/hadoop/hadoop-policy.xml: valid
# /home/hdfs-admin/hadoop/etc/hadoop/core-site.xml: valid 
# /home/hdfs-admin/hadoop/etc/hadoop/kms-site.xml: valid   
# /home/hdfs-admin/hadoop/etc/hadoop/kms-acls.xml: valid   
# /home/hdfs-admin/hadoop/etc/hadoop/mapred-site.xml: valid
# /home/hdfs-admin/hadoop/etc/hadoop/hdfs-site.xml: valid  
# OK
## copiar archivo a todos los nodos
scp ~/hadoop/etc/hadoop/core-site.xml nodo02:~/hadoop/etc/hadoop/;
scp ~/hadoop/etc/hadoop/core-site.xml nodo03:~/hadoop/etc/hadoop/;
scp ~/hadoop/etc/hadoop/core-site.xml nodo04:~/hadoop/etc/hadoop/;

## verificar 
cat  ~/hadoop/etc/hadoop/core-site.xml
```

#### 2.- hadoop conf nodos [[hdfs-hadoop/archivos/hdfs-site.xml|hdfs-site.xml]]

##### 2.1  [[hdfs-site.xml-namenode]]
![[hdfs-site.xml-namenode]]
![[hdfs-hadoop/archivos/workers|workers]]
![[hdfs-hadoop/archivos/decomisados|decomisados]]

```bash
# creamos una carpeta para guardar los datos de namenode
sudo chown -R hdfs-admin:hdfs-admin ~/discogrande;
mkdir ~/discogrande/namenode;
mkdir ~/discogrande/datanode;
ls -la  ~/discogrande/
## solo en namenode
touch ~/hadoop/etc/hadoop/decomisados
# configuramos los nameNodes
sudo nano ~/hadoop/etc/hadoop/hdfs-site.xml
sudo nano ~/hadoop/etc/hadoop/workers
```

##### 2.2  [[hdfs-site.xml-datanode]]
![[hdfs-site.xml-datanode]]

```bash
# configuramos los dataNodes
sudo nano ~/hadoop/etc/hadoop/hdfs-site.xml
## copiar archivo a todos los dataNodes
scp ~/hadoop/etc/hadoop/hdfs-site.xml nodo02:~/hadoop/etc/hadoop/;
scp ~/hadoop/etc/hadoop/hdfs-site.xml nodo03:~/hadoop/etc/hadoop/;
scp ~/hadoop/etc/hadoop/hdfs-site.xml nodo04:~/hadoop/etc/hadoop/:

## verificar etiquetas estan bien escritas en arch hadoop
hadoop conftest
```

#### 3.-establecer la tabla de particiones
```bash
hdfs namenode -format
```

#### 4.- levantar todos los nodos

```bash
start-dfs.sh
stop-dfs.sh
```

>[!my-ouput]-  ouput - start-dfs.sh
>```bash title="oput" 
> Starting namenodes on [nodo01]
> Starting datanodes
> nodo04: WARNING: /home/hdfs-admin/hadoop/logs does not exist. Creating.
> nodo03: WARNING: /home/hdfs-admin/hadoop/logs does not exist. Creating.
> nodo02: WARNING: /home/hdfs-admin/hadoop/logs does not exist. Creating.
> Starting secondary namenodes [nodo01]
> ```

#### 5.- web

[http://192.168.0.101:9870](http://192.168.0.101:9870)
[http://nodo01:9870](http://nodo01:9870)

![[hdfs-hadoop-web-datanodes.png]]

![[hdfs-hadoop-web-overview-01.png]]

![[hdfs-hadoop-web-overview-02.png]]