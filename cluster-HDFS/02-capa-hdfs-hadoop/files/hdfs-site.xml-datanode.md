
> archivo`hdfs-site.xml` en los nodos datanode
>
>>[!my-desc]-  description hdfs-site
>>
>> - `hdfs-site.xml`
>>
>> - archivo donde configuramos las configuration de hadoop de los nodos
>> - hay configuraciones asociadas a los [[nodo-namenode]] y a los [[nodo-datanode]]
>> - podíamos configurar un único archivo 
>> - hadoop se encarga de 
>> 	- si el nodo es tipo namenode solo le las propiedades de su tipo
>> 	- si el nodo es tipo datanode solo le las propiedades de su tipo 
>
>>[!my-param]- parametros
>>
>> | name | value | descripción |
>> |-|-|-|
>> |`dfs.datanode.data.dir`| `~/discogrande/datanode` |<ul><li>necesario para la persistencia de archivos</li><li>identifica la ruta donde se guardan los archivos</li><li>default se guarda en un archivo temporal, no hay persistencia</ul>|
>
>>[!my-code]- código
>>
>>```xml
>><?xml version="1.0" encoding="UTF-8"?>
>><?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
>><!--
>>  Licensed under the Apache License, Version 2.0 (the "License");
>>  you may not use this file except in compliance with the License.
>>  You may obtain a copy of the License at
>>
>>    http://www.apache.org/licenses/LICENSE-2.0
>>
>>  Unless required by applicable law or agreed to in writing, software
>>  distributed under the License is distributed on an "AS IS" BASIS,
>>  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
>>  See the License for the specific language governing permissions and
>>  limitations under the License. See accompanying LICENSE file.
>>-->
>>
>><!-- Put site-specific property overrides in this file. -->
>>
>><!--
>>  more configuration property
>>  https://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml
>>
>>  nota:
>>  al modificar este archivo se puede configurar en caliente
>>  hdfs dfsadmin -reconfig namenode bie1:9000 start
>>-->
>><!--
>>============================================================
>>=              Configuration DATANODE                      =
>>============================================================
>>-->
>><configuration>
>>    <!--
>>    dfs.datanode.data.dir
>>
>>    - - - - - - - - - - - - - - - - - - - - - - - -
>>    Ruta donde se guardan los datos de datanode
>>    -->
>>    <property>
>>        <name>dfs.datanode.data.dir</name>
>>        <value>/home/hdfs-admin/discogrande/datanode</value>
>>    </property>
>>
>></configuration>
>>```
```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>~/discogrande/datanode</value>
  </property>
</configuration>
```