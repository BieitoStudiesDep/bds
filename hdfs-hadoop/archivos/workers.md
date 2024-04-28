>
>>[!my-desc]-  description
>>
>> - `workers`
>> - incluimos el nombre de los nodos que tendrán la función de `dataNodes` 
>> - la ruta de este archivo debe estar definida en 
>> 	- [[hdfs-site.xml]] en la propiedad `dfs.hosts`
>> - es necesario definir una ruta para la persistencia de los archivos
>
```bash
# nodo01 - no lo incluimos por que va ser el nameNodeo
# incluimos los dataNodes
nodo02
nodo03
nodo04
```