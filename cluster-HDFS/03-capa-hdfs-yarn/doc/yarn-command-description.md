


> [!my-code]-  `start-yarn.sh`
> - crea un ResourceManager en el nodo indicado
> - crea un NodeManager en los demas nodos
> - se pude visualizar en el nodo con el comando `jps`
> ```bash
> start-yarn.sh
> ```

> [!my-code]-  `jps`
> - revisa los proceso que ejecuta java por consola 
> - en nuestro caso si esta actuando un datanode un namenode
> 
> ```bash
> jps
> ```
>>[!my-ouput]-  ouput -jps
>>```bash title="oput" 
>> 
>> ```

> [!my-code]-  `yar jar`
> - ejecuta un programa java con yarn
> - 
>| yarn | ruta del ejecutable java compilado | clase a ejecutar | ruta-hdfs datos de entrada |  ruta-hdfs datos de entrada|
>|-|-|-|-|-|
>|yarn jar|/home/hdfs-admin/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.0.jar|wordcount|/datos.txt|/salida|
>
>```bash
>yarn jar /home/hdfs-admin/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.0.jar wordcount /datos.txt /salida
>```

