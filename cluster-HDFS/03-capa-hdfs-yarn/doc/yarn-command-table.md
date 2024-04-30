
| comando | descripción |
|-|-|
|`start-yarn.sh` |inicia la capa de procesado  yarn |
|`stop-yarn.sh` |detiene la capa de procesado  yarn |
|`jps` |revisa los proceso que ejecuta java por consola </br> en nuestro caso si esta actuando un datanode un namenode ...|




|**COMANDO**|**DESCRIPCIÓN**|
|---|---|
|hdfs dfs -ls /|Lista todos los ficheros y directorios para el path /|
|hdfs dfs -ls -h /|Lista los ficheros con su tamaño en formato legible|
|hdfs dfs -ls -R /|Lista todos los ficheros y directorios recursivamente (con subdirectorios)|
|hdfs dfs -ls /file*|Lista todos los ficheros que cumplen el patrón (ficheros que comienzan con ‘file’)|
|hadoop fs -stat «type:%F» /|Imprime estadísticas del fichero o directorio en el formato indicado|

## Leer y Escribir Ficheros

|**COMANDO**|**DESCRIPCIÓN**|
|---|---|
|hdfs dfs -text /app.log|Imprime el fichero en modo texto por la terminal|
|hdfs dfs -cat /app.log|Muestra el contenido del fichero en la salida estándar|
|hdfs dfs -appendToFile /home/file1 /file2|Añade el contenido del fichero local ‘file1’ al fichero en HDFS ‘file2’|

## Cargar y Descargar Ficheros

|**COMANDO**|**DESCRIPCIÓN**|
|---|---|
|hdfs dfs -put /home/file1 /hadoop|Copia el fichero ‘file1’ del sistema de ficheros local a HDFS|
|hdfs dfs -put -f /home/file1 /hadoop|Copia el fichero ‘file1’ del sistema de ficheros local a HDFS y lo sobreescribe en el caso de que ya exista|
|hdfs dfs -put -l /home/file1 /hadoop|Copia el fichero ‘file1’ del sistema de ficheros local a HDFS. Fuerza replicación 1 y permite al DataNode persistir los datos de forma perezosa.|
|hdfs dfs -put -p /home/file1 /hadoop|Copia el fichero ‘file1’ del sistema de ficheros local a HDFS. Mantiene los tiempos de acceso, de modificación y propietario original|
|hdfs dfs -get /file1 /home/|Copia el fichero ‘file1’ de HDFS al sistema de ficheros local|
|hdfs dfs -copyToLocal /file1 /home/|Copia el fichero ‘file1’ de HDFS al sistema de ficheros local (igual que el anterior)|
|hdfs dfs -moveFromLocal /home/file1 /hadoop|Copia el fichero ‘file1’ del sistema de ficheros local a HDFS y luego lo borra del sist. ficheros local|
|||

## Gestión de Ficheros

|**COMANDO**|**DESCRIPCIÓN**|
|---|---|
|hdfs dfs -cp /hadoop/file1 /hadoop1|Copia el fichero al directorio destino en HDFS|
|hdfs dfs -cp -p /hadoop/file1 /hadoop1|Copia el fichero al directorio destino en HDFS conservando tiempos de acceso y de modificación, propietario y modo|
|hdfs dfs -rm /hadoop/file1|Elimina el fichero ‘file1’ de HDFS y lo envía a la papelera|
|hdfs dfs -rm -r /hadoop  <br>hdfs dfs -rm -R /hadoop  <br>hdfs dfs -rmr /hadoop|Elimina el directorio y su contenido en HDFS|
|hdfs dfs -rm -skipTrash /file1|Elimina el fichero sin dejarlo en la papelera|
|hdfs dfs -mkdir /hadoop2|Crea un directorio en HDFS|
|hdfs dfs -touchz /hadoop3|Crea un fichero en HDFS con tamaño 0|
|hadoop fs -getmerge -nl /file1 /file2 /output|Concatena los ficheros file1 y file2 en el fichero destino /output|

## Gestión de Permisos

|**COMANDO**|**DESCRIPCIÓN**|
|---|---|
|hdfs dfs -checksum /hadoop/file1|Muestra la información checksum del fichero|
|hdfs dfs -chmod 775 /hadoop/file1|Cambia los permisos del fichero en HDFS|
|hdfs dfs -chmod -R 755 /hadoop|Cambia los permisos de los ficheros recursivamente|
|hdfs dfs -chown hadoop:hadoop /file1|Cambia el propietario y el grupo del fichero|
|hdfs dfs -chown -R hadoop:hadoop /file1|Cambia el propietario y el grupo recursivamente|
|hdfs dfs -chgrp hadoop /file1|Cambia el grupo del fichero|

## Comandos de Administración HDFS

|**COMANDO**|**DESCRIPCIÓN**|
|---|---|
|hdfs dfs -df /hadoop|Muestra la capacidad y el espacio libre y usado del sistema de ficheros|
|hdfs dfs -df -h /hadoop|Muestra la capacidad y el espacio libre y usado del sistema de ficheros en formato legible|
|hadoop version|Muestra la versión de hadoop|
|hdfs fsck /|Comprueba el estado de salud del sistema de ficheros|
|hdfs dfsadmin -safemode leave|Deshabilita el modo seguro del NameNode|
|hdfs namenode -format|Formatea el NameNode|
|hadoop fs -test -e filename|Si el path existe en HDFS, devuelve 0|
|hadoop fs -setrep -w 3 /file1|Cambia el factor de replicación de un fichero a 3. Si se indica un directorio, cambia el factor de replicación de todos los ficheros que contiene|