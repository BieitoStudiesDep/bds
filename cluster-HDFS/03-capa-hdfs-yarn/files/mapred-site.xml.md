archivo`mapred-site.xml` en los nodos datanode y namenode

>[!my-desc]-  description
>
> - `hdfs-site.xml`
>> -`sudo nano ~/hadoop/etc/hadoop/mapred-site.xml`
>
> - archivo donde 
>> - determinamos que usamos un sistema de almacenamiento distribuido
>> - defiinimos las clases (java) que va a usar mapreducer
>
> - parámetros necesarios:
>> - `mapreduce.framework.name`
>>> - es necesario para usar un sistema distribuido de almacenamiento
>>> - de lo contrario solo almacena en local
>>- `mapreduce.application.classpath`
>>>- necesario indicar las librerías de java para que funcione mapreduce 

>[!my-param]-  parámetros
>
> | name | default | current |descripción |
> |-|-|-|-|
> |`mapreduce.framework.name`| local | yarn|<ul><li>El marco de tiempo de ejecución para ejecutar trabajos de MapReduce </li><li><b>valores :</b> </br><dl><dt>local (default)</dt><dd>procesara solo en el nodo en el que se ejecuta el archivo </dd><dt>classic  </dt><dt> yarn</dt><dd>valor distribuido usa todos los nodos</dd></li></ul>|
> |`mapreduce.application.classpath`| - | `/home/hdfs-admin/hadoop/mapreduce/*`</br>`/home/hdfs-admin/hadoop/share/hadoop/mapreduce/*` |ruta donde están las librerías que dan soporte a `mapreduce`|

 ```xml
 <configuration>
     <property>
         <name>mapreduce.framework.name</name>
         <value>yarn</value>
     </property>
     <property>
         <name>mapreduce.application.classpath</name>
         <value>
	         /home/hdfs-admin/hadoop/mapreduce/*,
	         /home/hdfs-admin/hadoop/share/hadoop/mapreduce/*
	     </value>
     </property>
 
 </configuration>
 ```


>[!my-param]- other params
>
> [otras propiedades para mapred-site.xml](https://hadoop.apache.org/docs/r2.7.1/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
> 
>|name|value|description|
>|---|---|---|
>|mapreduce.framework.name|local|The runtime framework for executing MapReduce jobs. Can be one of local, classic or yarn.|
>|mapreduce.application.classpath||CLASSPATH for MR applications. A comma-separated list of CLASSPATH entries. If mapreduce.application.framework is set then this must specify the appropriate classpath for that archive, and the name of the archive must be present in the classpath. If mapreduce.app-submission.cross-platform is false, platform-specific environment vairable expansion syntax would be used to construct the default CLASSPATH entries. For Linux: $HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*, $HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*. For Windows: %HADOOP_MAPRED_HOME%/share/hadoop/mapreduce/*, %HADOOP_MAPRED_HOME%/share/hadoop/mapreduce/lib/*. If mapreduce.app-submission.cross-platform is true, platform-agnostic default CLASSPATH for MR applications would be used: {{HADOOP_MAPRED_HOME}}/share/hadoop/mapreduce/*, {{HADOOP_MAPRED_HOME}}/share/hadoop/mapreduce/lib/* Parameter expansion marker will be replaced by NodeManager on container launch based on the underlying OS accordingly.|