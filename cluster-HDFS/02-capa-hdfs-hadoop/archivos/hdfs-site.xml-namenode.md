
>
>>[!my-param]-   [[nodo-namenode]] [[cluster-HDFS/02-capa-hdfs-hadoop/conf/datanode/hdfs-site.xml]] param
>>
>> | name | value | descripción |
>> |-|-|-|
>> |`dfs.namenode.name.dir`| `~/discogrande/namenode` |<ul><li>necesario para la persistencia de archivos</li><li>identifica la ruta donde se guardan los archivos</li><li>default se guarda en un archivo temporal, no hay persistencia</ul>|
>
>>[!my-code]-  [[nodo-namenode]] [[cluster-HDFS/02-capa-hdfs-hadoop/archivos/hdfs-site.xml|hdfs-site.xml]] code
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
>> ============================================================
>> =              Configuration NAMENODE                      =
>> ============================================================
>>-->
>><configuration>
>>  <!--
>>      dfs.namenode.name.dir
>>              file://${hadoop.tmp.dir}/dfs/name
>>              Determines where on the local filesystem the DFS name node should store the
>>              name table(fsimage).
>>              If this is a comma-delimited list of directories then the name
>>              table is replicated in all of the directories, for redundancy.
>>    - - - - - - - - - - - - - - - - - - - - - - - -
>>      Ruta donde esta guarda la table de direcciones de namenode
>>    -->
>>  <property>
>>    <name>dfs.namenode.name.dir</name>
>>    <value>/home/hdfs-admin/discogrande/namenode</value>
>>  </property>
>>  <!--
>>      dfs.replication
>>              default 3
>>              Default block replication. The actual number of replications
>>              can be specified when the file is
>>    created. The default is used if replication is not specified in create time.
>>    - - - - - - - - - - - - - - - - - - - - - - - -
>>    Cuando guardas un archivo en Hadoop,
>>            el archivo se divide en fragmentos de datos llamados "bloques"
>>                default (128 MB). estos bloques se guardan en n nodos
>>                siendo n el valor de dfs.replication,
>>                en este caso como el valor es 2 se guarda cada "bloque" en 2 nodos.
>>    -->
>>  <property>
>>    <name>dfs.replication</name>
>>    <value>2</value>
>>  </property>
>>  <!--
>>      dfs.heartbeat.interval
>>              default 3
>>              Determines datanode heartbeat interval in seconds.
>>      - - - - - - - - - -
>>      tiempo que tarde en mili-segundos en dar un latido
>>    -->
>>  <property>
>>    <name>dfs.heartbeat.interval</name>
>>    <value>1</value>
>>  </property>
>>  <!--
>>      dfs.namenode.heartbeat.recheck-interval
>>              default   300000
>>              300000    This time decides the interval to check for expired datanodes.
>>      With this value and
>>              dfs.heartbeat.interval, the interval of deciding the datanode
>>              is stale or not is also
>>          calculated. The unit of this configuration is millisecond.
>>      - - - - - - - - - - - - - - - - - - - - - - - -
>>      En el proceso de declarar un nodo como muerto
>>      tras no responder un nodo tras 10 latidos
>>      hadoop establece w periodos de gracia
>>      tiempo en mili-segundos de cada periodo de gracia :
>>    -->
>>  <property>
>>    <name>dfs.namenode.heartbeat.recheck-interval</name>
>>    <value>500</value>
>>  </property>
>>  <!--
>>      dfs.hosts
>>      Names a file that contains a list of hosts that are permitted
>>      to connect to the namenode.
>>       The full pathname of the file must be specified. If the value is empty,
>>       all hosts are permitted.
>>      - - - - - - - - - - - - - - - - - - - - - - - -
>>      - habitualmente usamos el archivo `~/hadoop/etc/hadoop/workers`
>>      - archivo que ya viene dentro de la conf de hadoop
>>      - archivo usado conmunmente en otros procesos
>>    -->
>>  <property>
>>    <name>dfs.hosts</name>
>>    <value>/home/hdfs-admin/hadoop/etc/hadoop/workers</value>
>>  </property>
>>  <!--
>>      dfs.hosts.exclude
>>      Names a file that contains a list of hosts that are permitted
>>      to connect to the namenode.
>>       The full pathname of the file must be specified. If the value is empty,
>>       all hosts are permitted.
>>      - - - - - - - - - - - - - - - - - - - - - - - -
>>      - ruta del archivo que contiene el nombre de los nodos
>>              - que va a ser decomisados
>>      - nodos que por alguna razon (mantenimiento etc)
>>              - van a estar fuera del sistema durante algun tiempo
>>      - en el momento que hadoop declaren como muertos
>>              - hadoop no desencadenará ninguna copia de bloques
>>              - por que ya la ha echo antes
>>      - necesario crear la ruta `~/hadoop/etc/hadoop/decomisados`
>>      - definimos una ruta para los host excluidos decomisados
>>      - decomisiar un nodo es
>>              - indicarle a hadoop que ese nodo
>>              - va a ser apagado por razones de mantenimiento etc ..
>>              - y que por lo tanto aparecerá como muerto en algun momento
>>              - hadoop hara las copias que contiene ese nodo.
>>    -->
>>  <property>
>>    <name>dfs.hosts.exclude</name>
>>    <value>/home/hdfs-admin/hadoop/etc/hadoop/decomisados</value>
>>  </property>
>>
>></configuration>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>

  <property>
    <name>dfs.namenode.name.dir</name>
    <value>/home/hdfs-admin/discogrande/namenode</value>
  </property>

  <property>
    <name>dfs.replication</name>
    <value>2</value>
  </property>
  
  <property>
    <name>dfs.heartbeat.interval</name>
    <value>1</value>
  </property>
  
  <property>
    <name>dfs.namenode.heartbeat.recheck-interval</name>
    <value>500</value>
  </property>
  
  <property>
    <name>dfs.hosts</name>
    <value>/home/hdfs-admin/hadoop/etc/hadoop/workers</value>
  </property>
  
  <property>
    <name>dfs.hosts.exclude</name>
    <value>/home/hdfs-admin/hadoop/etc/hadoop/decomisados</value>
  </property>

</configuration>
```