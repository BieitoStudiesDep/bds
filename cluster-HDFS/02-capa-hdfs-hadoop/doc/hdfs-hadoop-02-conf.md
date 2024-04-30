
#### Hadoop-Config
>
>>[!my-folder]-   hdf-hadoop `archivos`
>>![[hadoop-files]]
>
>>[!my-code]-   hdf-hadoop `comands`
>>![[hadoop-command]]]
>
>> [!Info]- hdf-hadoop  `configuración`
>> [[#1.- hadoop - identificar el nodo que actúa como principal core-site.xml]]
>> 
>> [[#2.- hadoop conf nodos hdfs-site.xml]]
>> 
>>  - [[#2.1 hdfs-site.xml-namenode]]
>>  - [[#2.2 hdfs-site.xml-datanode]]
>> 
>> [[#3.-establecer la tabla de particiones]]
>> 
>> [[#4.- levantar todos los nodos]]
>>
>> [[#5.- web]]

```bash
ls ~/hadoop/etc/hadoop/core-site.xml
tree ~/hadoop/etc/hadoop/
```



#### 1.- hadoop - identificar el nodo que actúa como principal core-site.xml
- configuración idéntica para
	- namenodes
	- datanodes

![[core-site.xml]]

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

#### 2.- hadoop conf nodos hdfs-site.xml

##### 2.1  hdfs-site.xml-namenode
![[hdfs-site.xml-namenode]]
![[workers|workers]]
![[decomisados|decomisados]]

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

##### 2.2  hdfs-site.xml-datanode
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

![[hadoop-web]]