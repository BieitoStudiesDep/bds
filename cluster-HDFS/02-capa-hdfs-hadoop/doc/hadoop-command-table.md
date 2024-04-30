

| comando | descripción |
|-|-|
|`hadoop conftest`| indica si los archivos de hadoop estan sintacticamente bien construidos en cuanto a sus etiquetas, no identifica los errores  del contenido de las mismas|
|`scp ~/hadoop/etc/hadoop/core-site.xml nodo02:~/hadoop/etc/hadoop/`| copiar archivo de origen al nodo02 |
|hdfs namenode -format| crea la tabla de patriciones en el namenode|
|`start-dfs.sh` |inicia los servicios hdfs namenodes y datanodes|
|`start-dfs.sh` |para los servicios hdfs namenodes y datanodes|
|`jps` |revisa los proceso que ejecuta java por consola </br> en nuestro caso si esta actuando un datanode un namenode ...|
|`hdfs dfs -put /tmp/datos.txt /`||
|`hdfs dfs -ls /`||
