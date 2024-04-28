>[!info]- parámetros del entorno
>
> |mv-name|hdfs|ip|-|
> |-|-|-|-|
> |hadoop-template|-|192.168.0.100|-|
> |hadoop-nodo01|namenode|192.168.0.101|-|
> |hadoop-nodo02|datanode|192.168.0.102|-|
> |hadoop-nodo03|datanode|192.168.0.103|-|
> |hadoop-nodo04|datanode|192.168.0.104|-|
>
> |hardware|value|
> |-|-|
> |ram|2048MB|
> |procesadores|2|
> |internal-disk|100G|
> |data-disk|500G|
>
> |user|password|
> |-|-|
> |hdfs-admin|abc123.|

>[!info]- install guest additions
>
>```bash
># install guest additions
>sudo apt-get install gcc make perl
>```

>[!info]- connection host-nodos
>
>```bash
>ssh hdfs-admin@192.168.0.100
>ssh hdfs-admin@192.168.0.101
>ssh hdfs-admin@192.168.0.102
>ssh hdfs-admin@192.168.0.103
>ssh hdfs-admin@192.168.0.104
>```
