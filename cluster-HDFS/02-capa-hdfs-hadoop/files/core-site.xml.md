> archivo`core-site.xml` en los nodos datanode y namenode
>
>>[!my-desc]-  description
>>
>> - `hdfs-site.xml`
>>
>> - archivo donde configuramos el nodo01 como namenode
>> - replicarlo en todos los nodos
>> - Todos los nodos deben saber cual es el nodo principal
>>`sudo nano ~/hadoop/etc/hadoop/capacity-scheduler.xml`
>> params:
>>> - `dfs.namenode.name.dir`
>>> - es necesario definir una ruta para la persistencia de los archivos
>>
>
>>[!my-param]-  parámetros
>>
>> | name | value | descripción |
>> |-|-|-|
>> |`fs.defaultFS`| `hdfs://nodo01:9000` |<ul><li>indicamos la ruta hdfs </li><li>al nodo que tendrá la función de [[nodo-namenode]] </li><li>por el puerto :9000</ul>|
>
>>[!my-code]-  [[nodo-namenode]] y [[nodo-datanode]] [[core-site.xml|core-site.xml]] code
>>
>> ```xml
>> <configuration>
>>     <!--
>>       `fs.defaultFS`
>>         propiedad que define el sistema de archivos por defecto que utilizará Hadoop , indicamos la
>>     dirección del namenode a la que debe conectarse Hadoop
>>        hdfs://bie1:9000=
>>       `hdfs`   sistema de archivos por defecto utilizado por Hadoop será HDFS (Hadoop Distributed File
>>     System)
>>       `bie1` la dirección del namenode
>>       `:9000`  puerto 9000.
>>     -->
>>     <property>
>>         <name>fs.defaultFS</name>
>>         <value>hdfs://nodo01:9000</value>
>>     </property>
>> 
>> </configuration>
>> ```

```xml
 <configuration>
     <property>
         <name>fs.defaultFS</name>
         <value>hdfs://nodo01:9000</value>
     </property>
 
 </configuration>
```
