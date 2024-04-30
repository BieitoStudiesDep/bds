---
tags:
  - ceia-bds
  - hdfs
type:
  - video
issue: hdfs-yarn
concept: configuración-capa-yarn
📹:
  - https://www.youtube.com/watch?v=XP5kbGrk8oc
parent:
  - "[[cluster-HDFS]]"
pre:
  - "[[capa-hdfs-hadoop]]"
---
![# Configuración de la capa YARN](https://www.youtube.com/watch?v=XP5kbGrk8oc)



#### Yarn-Config
>
>>[!my-folder]-   hdf-yarn `archivos`
>>![[yarn-files]]
>
>>[!my-code]-   hdf-yarn `comands`
>>![[yarn-command]]]
>
>> [!Info]- hdf-yarn  `configuración`
>> [[#1.- hadoop - identificar el nodo que actúa como principal core-site.xml]]
>> 
>> [[#2.- hadoop conf nodos hdfs-site.xml]]
>> 
>>  - [[#2.1 hdfs-site.xml-namenode]]
>>  - [[#2.2 hdfs-site.xml-datanode]]
>> 
>> [[#3.-establecer la tabla de particiones]]
>> 
>> [[#4.- levantar todos los nodos]]
>>
>> [[#5.- web]]

#### 1.- mapred-site.xml definimos el uso de yarn sobre la capa de hadoop
![[mapred-site.xml]]

- copiar mapred-site.xml a todos los nodos
```bash
hadoop conftest
scp /home/hdfs-admin/hadoop/etc/hadoop/mapred-site.xml nodo02://home/hdfs-admin/hadoop/etc/hadoop/;
scp /home/hdfs-admin/hadoop/etc/hadoop/mapred-site.xml nodo03://home/hdfs-admin/hadoop/etc/hadoop/;
scp /home/hdfs-admin/hadoop/etc/hadoop/mapred-site.xml nodo04://home/hdfs-admin/hadoop/etc/hadoop/;
```

#### 2.- yarn-site.xml configuramos yarn
![[yarn-site.xml]]

- copiar mapred-site.xml a todos los nodos
```bash
hadoop conftest
scp /home/hdfs-admin/hadoop/etc/hadoop/yarn-site.xml nodo02://home/hdfs-admin/hadoop/etc/hadoop/;
scp /home/hdfs-admin/hadoop/etc/hadoop/yarn-site.xml nodo03://home/hdfs-admin/hadoop/etc/hadoop/;
scp /home/hdfs-admin/hadoop/etc/hadoop/yarn-site.xml nodo04://home/hdfs-admin/hadoop/etc/hadoop/;
```

#### 3.- levantar capa yarn
![[yarn-command]]

```bash
start-yarn.sh
start-all.sh
```

> [!my-ouput]- start-all.sh ouput
>
>>```bash
>>hdfs-admin@nodo01:~$ start-all.sh
>>WARNING: Attempting to start all Apache Hadoop daemons as hdfs-admin in 10 seconds.
>>WARNING: This is not a recommended production deployment configuration.
>>WARNING: Use CTRL-C to abort.
>>Starting namenodes on [nodo01]
>>Starting datanodes
>>Starting secondary namenodes [nodo01]
>>Starting resourcemanager
>>Starting nodemanagers
>>```
>
>|nodo01|nodo02|nodo03|nodo04|
>|-|-|-|-|
>|hdfs-admin@nodo01:~$ jps</br>11952 Jps</br>11251 NameNode</br>11653 ResourceManager</br>11451 SecondaryNameNode|hdfs-admin@nodo02:~$ jps</br>10917 Jps</br>10763 NodeManager</br>10637 DataNode</br>|hdfs-admin@nodo03:~$ jps</br>10883 Jps</br>10791 NodeManager</br>10665 DataNode</br>|hdfs-admin@nodo04:~$ jps</br>10597 Jps</br>10503 NodeManager</br>10377 DataNode</br>|

#### 4.- yarn web
![[yarn-web]]

#### 5.- mapreducer

- subir ficheros a hdfs
```bash
hdfs dfs -put datos.txt /
```

- programa ejemplo contador de palabras
```bash
echo -e "uno\nuno dos\nuno dos tres\nuno dos tres cuatro" > /tmp/datos.txt;
cat /tmp/datos.txt;
hdfs dfs -put /tmp/datos.txt /;
hdfs dfs -ls /;
```

- lanzar contador de palabras
```bash
hdfs-admin@nodo01:~$ ls /home/hdfs-admin/hadoop/share/hadoop/mapreduce/
hadoop-mapreduce-client-app-3.4.0.jar
hadoop-mapreduce-client-common-3.4.0.jar
hadoop-mapreduce-client-core-3.4.0.jar
hadoop-mapreduce-client-hs-3.4.0.jar
hadoop-mapreduce-client-hs-plugins-3.4.0.jar
hadoop-mapreduce-client-jobclient-3.4.0.jar
hadoop-mapreduce-client-jobclient-3.4.0-tests.jar
hadoop-mapreduce-client-nativetask-3.4.0.jar
hadoop-mapreduce-client-shuffle-3.4.0.jar
hadoop-mapreduce-client-uploader-3.4.0.jar
hadoop-mapreduce-examples-3.4.0.jar
jdiff
sources
```

| yarn | ruta del ejecutable java compilado | clase a ejecutar | ruta-hdfs datos de entrada |  ruta-hdfs datos de entrada|
|-|-|-|-|-|
|yarn jar|/home/hdfs-admin/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.0.jar|wordcount|/datos.txt|/salida|

```bash
yarn jar /home/hdfs-admin/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.0.jar wordcount /datos.txt /salida
```

> [!my-ouput]- yarn jar ouput
>
>```bash
> yarn jar /home/hdfs-admin/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.4.0.jar wordcount /datos.txt /salida
> 2024-04-30 19:04:32,597 INFO client.DefaultNoHARMFailoverProxyProvider: Connecting to ResourceManager at nodo01/192.168.0.101:8032
> 2024-04-30 19:04:33,304 INFO mapreduce.JobResourceUploader: Disabling Erasure Coding for path: /tmp/hadoop-yarn/staging/hdfs-admin/.staging/job_1714493383586_0001
> 2024-04-30 19:04:33,876 INFO input.FileInputFormat: Total input files to process : 1
> 2024-04-30 19:04:34,398 INFO mapreduce.JobSubmitter: number of splits:1
> 2024-04-30 19:04:34,789 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1714493383586_0001
> 2024-04-30 19:04:34,790 INFO mapreduce.JobSubmitter: Executing with tokens: []
> 2024-04-30 19:04:35,187 INFO conf.Configuration: resource-types.xml not found
> 2024-04-30 19:04:35,187 INFO resource.ResourceUtils: Unable to find 'resource-types.xml'.
> 2024-04-30 19:04:35,781 INFO impl.YarnClientImpl: Submitted application application_1714493383586_0001
> 2024-04-30 19:04:35,841 INFO mapreduce.Job: The url to track the job: http://nodo01:8088/proxy/application_1714493383586_0001/
> 2024-04-30 19:04:35,843 INFO mapreduce.Job: Running job: job_1714493383586_0001
> 2024-04-30 19:04:47,123 INFO mapreduce.Job: Job job_1714493383586_0001 running in uber mode : false
> 2024-04-30 19:04:47,126 INFO mapreduce.Job:  map 0% reduce 0%
> 2024-04-30 19:04:53,259 INFO mapreduce.Job:  map 100% reduce 0%
> 2024-04-30 19:05:03,397 INFO mapreduce.Job:  map 100% reduce 100%
> 2024-04-30 19:05:03,414 INFO mapreduce.Job: Job job_1714493383586_0001 completed successfully
> 2024-04-30 19:05:03,598 INFO mapreduce.Job: Counters: 54
>         File System Counters
>                 FILE: Number of bytes read=50
>                 FILE: Number of bytes written=618153
>                 FILE: Number of read operations=0
>                 FILE: Number of large read operations=0
>                 FILE: Number of write operations=0
>                 HDFS: Number of bytes read=138
>                 HDFS: Number of bytes written=28
>                 HDFS: Number of read operations=8
>                 HDFS: Number of large read operations=0
>                 HDFS: Number of write operations=2
>                 HDFS: Number of bytes read erasure-coded=0
>         Job Counters
>                 Launched map tasks=1
>                 Launched reduce tasks=1
>                 Data-local map tasks=1
>                 Total time spent by all maps in occupied slots (ms)=4078
>                 Total time spent by all reduces in occupied slots (ms)=6510
>                 Total time spent by all map tasks (ms)=4078
>                 Total time spent by all reduce tasks (ms)=6510
>                 Total vcore-milliseconds taken by all map tasks=4078
>                 Total vcore-milliseconds taken by all reduce tasks=6510
>                 Total megabyte-milliseconds taken by all map tasks=4175872
>                 Total megabyte-milliseconds taken by all reduce tasks=6666240
>         Map-Reduce Framework
>                 Map input records=4
>                 Map output records=10
>                 Map output bytes=85
>                 Map output materialized bytes=50
>                 Input split bytes=93
>                 Combine input records=10
>                 Combine output records=4
>                 Reduce input groups=4
>                 Reduce shuffle bytes=50
>                 Reduce input records=4
>                 Reduce output records=4
>                 Spilled Records=8
>                 Shuffled Maps =1
>                 Failed Shuffles=0
>                 Merged Map outputs=1
>                 GC time elapsed (ms)=158
>                 CPU time spent (ms)=1800
>                 Physical memory (bytes) snapshot=540098560
>                 Virtual memory (bytes) snapshot=5102919680
>                 Total committed heap usage (bytes)=382205952
>                 Peak Map Physical memory (bytes)=325701632
>                 Peak Map Virtual memory (bytes)=2548514816
>                 Peak Reduce Physical memory (bytes)=214396928
>                 Peak Reduce Virtual memory (bytes)=2554404864
>         Shuffle Errors
>                 BAD_ID=0
>                 CONNECTION=0
>                 IO_ERROR=0
>                 WRONG_LENGTH=0
>                 WRONG_MAP=0
>                 WRONG_REDUCE=0
>         File Input Format Counters
>                 Bytes Read=45
>         File Output Format Counters
>                 Bytes Written=28
>```

tras ejecutar yarn jar :
> en el directorio-htfs `htfs///salida`
>>- crea un archivo` _SUCCESS` sin peso para indicar que la operación se realizó con exito
>>- crea tantos `salida/part-r-00000` como reducers se hayan ejecutado
>>- crea en `htfs///temp/yarn` los registros necesarios

> [!my-ouput]- hdfs dfs -ls -R / ouput
>
>```bash
>hdfs dfs -ls -R /
>-rw-r--r--   2 hdfs-admin supergroup         45 2024-04-30 18:51 /datos.txt
>drwxr-xr-x   - hdfs-admin supergroup          0 2024-04-30 19:05 /salida
>-rw-r--r--   2 hdfs-admin supergroup          0 2024-04-30 19:05 /salida/_SUCCESS
>-rw-r--r--   2 hdfs-admin supergroup         28 2024-04-30 19:05 /salida/part-r-00000
>drwxr-xr-x   - hdfs-admin supergroup          0 2024-04-30 19:04 /tmp
>drwxr-xr-x   - hdfs-admin supergroup          0 2024-04-30 19:04 /tmp/hadoop-yarn
>drwxr-xr-x   - hdfs-admin supergroup          0 2024-04-30 19:04 /tmp/hadoop-yarn/staging
>drwxr-xr-x   - hdfs-admin supergroup          0 2024-04-30 19:04 /tmp/hadoop-yarn/staging/hdfs-admin
>drwx------   - hdfs-admin supergroup          0 2024-04-30 19:05 /tmp/hadoop-yarn/staging/hdfs-admin/.staging
>drwxr-xr-x   - hdfs-admin supergroup          0 2024-04-30 19:04 /tmp/hadoop-yarn/staging/history
>drwxrwxrwt   - hdfs-admin supergroup          0 2024-04-30 19:04 /tmp/hadoop-yarn/staging/history/done_intermediate
>drwxrwx---   - hdfs-admin supergroup          0 2024-04-30 19:05 /tmp/hadoop-yarn/staging/history/done_intermediate/hdfs-admin
>-rwxrwx---   2 hdfs-admin supergroup      22735 2024-04-30 19:05 /tmp/hadoop-yarn/staging/history/done_intermediate/hdfs-admin/job_1714493383586_0001-1714496675300-hdfs%2Dadmin-word+count-1714496701974-1-1-SUCCEEDED-root.default-1714496685615.jhist
>-rwxrwx---   2 hdfs-admin supergroup        445 2024-04-30 19:05 /tmp/hadoop-yarn/staging/history/done_intermediate/hdfs-admin/job_1714493383586_0001.summary
>-rwxrwx---   2 hdfs-admin supergroup     305702 2024-04-30 19:05 /tmp/hadoop-yarn/staging/history/done_intermediate/hdfs-admin/job_1714493383586_0001_conf.xml
>```

```bash
hdfs-admin@nodo01:~$ cat /tmp/datos.txt
uno
uno dos
uno dos tres
uno dos tres cuatro
hdfs-admin@nodo01:~$ hdfs dfs -cat /salida/*
cuatro  1
dos     3
tres    2
uno     4
hdfs-admin@nodo01:~$
```

> [!warning]+  si intentamos ejecutar sobre el mismo fichero de salida de nuevo
>- nos va a dar un error por que el fichero `salida` ya existe
>- `org.apache.hadoop.mapred.FileAlreadyExistsException: Output directory hdfs://nodo01:9000/salida already exists`