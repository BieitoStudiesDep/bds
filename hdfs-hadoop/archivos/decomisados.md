>
>>[!my-desc]-  description
>>
>> - `decomisados`
>> - archivo creado `touch ~/hadoop/etc/hadoop/decomisados`
>> - incluimos el nombre de los nodos que tendrán el estado de [[nodo-decomisado]] 
>> - la ruta de este archivo debe estar definida en 
>> 	- [[hdfs-site.xml]] en la propiedad `dfs.hosts.exclude`
>> - es necesario borrar el nombre del nodo una vez queramos que vuelva a formar parte del cluster
>> - normalmente se establece el estado decomisado por tareas de mantenimiento 
>
```bash
# nodos decomisados
# incluimos los nodos de nameNode decomisados
nodo05 # actualmente en tareas de mantenimiento
```