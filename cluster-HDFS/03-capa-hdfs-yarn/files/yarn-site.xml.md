archivo`yarn-site.xml` en los nodos datanode y namenode

>[!my-desc]-  description
>
> - `hdfs-site.xml`
>> - `sudo nano ~/hadoop/etc/hadoop/yarn-site.xml`
>
> - archivo donde configuramos 
>> - el nodo que actua como  [[yarn-resurcemanage]]
>> - servicios como [[mapreduce_shuffle]]
>
>- parámetros necesarios :
>> - `yarn.resourcemanager.hostname`
>>> - es necesario definir el nodo que acua como [[yarn-resurcemanage]]
>> - `yarn.nodemanager.aux-services`
>>> es necesario definir el servicios [[mapreduce_shuffle]]

>[!my-param]-  parámetros
>
> | name | value | descripción |
> |-|-|-|
> |`yarn.resourcemanager.hostname`| `nodo01` |nodo que funciona como  [[yarn-resurcemanage]]|
> |`yarn.nodemanager.aux-services`| `mapreduce_shuffle` |servicios auxiliares que queremos ejecutar </br> en nuestro caso: </br> [[mapreduce_shuffle]]  |

 ```xml
 <configuration>
     <property>
         <name>yarn.resourcemanager.hostname</name>
         <value>nodo01</value>
     </property>
     <property>
         <name>yarn.nodemanager.aux-services</name>
         <value>mapreduce_shuffle</value>
     </property>
 </configuration>
 ```


>[!my-param]- other params
>
> [otras propiedades para yarn-site.xml](https://hadoop.apache.org/docs/r2.7.3/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
> 
>|name|value|description|
>|---|---|---|
>|yarn.resourcemanager.hostname|0.0.0.0|The hostname of the RM.|
>|yarn.nodemanager.aux-services||A comma separated list of services where service name should only contain a-zA-Z0-9_ and can not start with numbers|

