# Dudas sbd02-01

## Usuarios y Permisos

### Duda Enviada Email Javi

Intentando explicar y justificar porque asigno estos permisos al entorno mongodb me surgen las siguientes dudas, espero no liarme demasiado al plantearlas.

- intentando optimizar y prevenir errores decido que lo ideal es que el entorno pertenezca al usuario mongodb y grupo mongodb, pero con `/home/bieito/.mongodb` tengo dudas.

- me pierdo un poco en que es lo que realmente hace el usuario mongodb, es decir actúa como usuario en el sistema y ejecuta el servidor mediante mongod, pero tiene alguna función dentro del servicio entorno mongodb, es decir en la conexión

```bash
    # interna desde el usuario logueado
    mongosh
    # externa desde fuera
    # en el caso de la practica no nos conectamos sin indicar usuario
    mongo "mongodb://192.168.0.50:27017/"
    # conexión habitual indicamos usuarios
    username=mongodb
    mongo_server_ip=192.168.0.50
    mongo "mongodb://$username@$mongo_server_ip:27017"
    mongo "mongodb://mongodb@192.168.0.50:27017"
```

- al no tener en la base de datos establecidos usuarios
  entiendo que en los dos caso ejecutamos las operaciones lectura /escritura en la db se establecen mediante el servidor que se asigna al usuario mongodb.

- mi pregunta es a nivel de sistema todas las operaciones realizadas en el servidor se van a asignar al usuario mongodb. Y con lo cual es el único que debe tener permisos de escritura.

- sobre el uso del grupo mongodb
  cuando creemos usuarios para la mongodb estos ban a pertenecer al grupo mongodb con lo cual necesitan permisos de escritura o van a estar una capa por encima del usuario mongodb y van a ser simples usuarios del servicio con lo cual la escritura siembre la genera user:mongodb

- en el entorno para los permisos otros (r-w), tiene sentido que el user:bieito tenga algún tipo de permiso

- en (/home/bieito/) user:mongodb entiendo que necesita permisos de (r) para poder leer ejecutar y escribir en los hijos de dichos directorios pero (x) los permisos de ejecución son obligatorios.

### Configuración actual

permisos

en `\home\bieito`

- `otros: r-x` necesitamos con el usuario `mongodb` permisos de lectura y ejecución para poder llegar a los directorios de la estructura mongodb pero con `/home/bieito/.mongodb` tengo dudas.

`drwxr-xr-x 13 bieito  bieito  4096 feb 27 00:35 bieito`

para evitar problemas en todo la estructura mongodb

- `/home/bieito/mongo` # ejecutables mongod mongos
- `/home/bieito/log` # archivos de log de mongo
- `/home/bieito/datos` # archivos datos de mongo
- `/home/bieito/mongo-tools` # ejecutables de mongo-tools
- `/home/bieito/mongo-download` # donde descargo los .tar de la web official
- `/home/bieito/.mongodb`

este entorno va a pertenecer a

- usuario `mongodb` lectura , escritura y ejecución : `drwx`.
- grupo `mongodb` lectura y ejecución : `r-x`
- otros lectura y ejecución : `r-x`
- el único que tiene permisos de escritura es el usuario mongodb
- entiendo que las operaciones del servidor de mongod se ejecutan a trabes de `mongodb` por lo tanto este usuario escribiría en data, log y es el que ejecutaría los binarios de cara al servidor.
- de cara al cliente como tienen permisos de lectura y escritura los demás usuarios podría efectuar acciones.

```bash
    drwxr-xr-x  2 mongodb mongodb  4096 feb 24 04:49 log
    drwxr-xr-x  3 mongodb mongodb  4096 feb 24 05:29 mongo
    drwx------  3 bieito  bieito   4096 feb 27 00:30 .mongodb
    drwxr-xr-x  2 mongodb mongodb  4096 feb 27 00:34 mongo-download
    drwxr-xr-x  3 mongodb mongodb  4096 feb 19 11:00 mongosh
    drwxr-xr-x  3 mongodb mongodb  4096 feb 27 00:32 mongo-tools
```

````bash
    # permisos para el usuario mongodb
    sudo chown -R mongodb:mongodb /home/bieito/mongo;
    sudo chown -R mongodb:mongodb /home/bieito/log;
    sudo chown -R mongodb:mongodb /home/bieito/datos;
    sudo chown -R mongodb:mongodb /home/bieito/mongo-tools;
    sudo chown -R mongodb:mongodb /home/bieito/mongo-download;
    sudo chown -R mongodb:mongodb /home/bieito/.mongodb;
    # permisos adecuados en los directorios para ambos usuarios:
    sudo chmod -R 755 /home/bieito/mongo;
    sudo chmod -R 755 /home/bieito/log;
    sudo chmod -R 755 /home/bieito/datos;
    sudo chmod -R 755 /home/bieito/mongo-tools;
    sudo chmod -R 755 /home/bieito/mongo-download;
    sudo chmod -R 755 /home/bieito/.mongodb;
    # verificar
    sudo ls -la /home/ | grep "bieito"
    sudo ls -la /home/bieito/
    sudo ls -la /home/bieito/mongo/bin | grep -E 'mongod|mongos'
    ```

    ```bash
    mongodb@bieitoserver:~$ sudo ls -la /home/ | grep "bieito"
        drwxr-xr-x 13 bieito  bieito  4096 feb 27 00:35 bieito
    mongodb@bieitoserver:~$ sudo ls -la /home/bieito/
        total 76
        drwxr-xr-x 13 bieito  bieito   4096 feb 27 00:35 .
        drwxr-xr-x  4 root    root     4096 feb 24 04:50 ..
        -rw-------  1 bieito  bieito  11385 feb 29 15:22 .bash_history
        -rw-r--r--  1 bieito  bieito    220 ene  6  2022 .bash_logout
        -rw-r--r--  1 bieito  bieito   3771 ene  6  2022 .bashrc
        drwx------  2 bieito  bieito   4096 feb 23 23:20 .cache
        drwx------  4 bieito  bieito   4096 feb 24 02:56 .config
        drwxr-xr-x  4 mongodb mongodb  4096 feb 29 16:50 datos
        drwxrwxr-x  3 bieito  bieito   4096 feb 24 05:02 .local
        drwxr-xr-x  2 mongodb mongodb  4096 feb 24 04:49 log
        drwxr-xr-x  3 mongodb mongodb  4096 feb 24 05:29 mongo
        drwxr-xr-x  3 mongodb mongodb  4096 feb 27 00:30 .mongodb
        drwxr-xr-x  2 mongodb mongodb  4096 feb 27 00:34 mongo-download
        drwxr-xr-x  3 mongodb mongodb  4096 feb 19 11:00 mongosh
        drwxr-xr-x  3 mongodb mongodb  4096 feb 27 00:32 mongo-tools
        -rw-r--r--  1 bieito  bieito    807 ene  6  2022 .profile
        drwx------  2 bieito  bieito   4096 feb 23 23:15 .ssh
        -rw-r--r--  1 bieito  bieito      0 feb 23 23:22 .  sudo_as_admin_successful
    mongodb@bieitoserver:~$ sudo ls -la /home/bieito/mongo/bin | grep -E    'mongod|mongos'
        drwxr-xr-x 2 mongodb mongodb      4096 feb 24 05:29 .
        drwxr-xr-x 3 mongodb mongodb      4096 feb 24 05:29 ..
        -rwxr-xr-x 1 mongodb mongodb     15141 nov 15 21:12 install_compass
        -rwxr-xr-x 1 mongodb mongodb 181872200 nov 15 22:38 mongod
        -rwxr-xr-x 1 mongodb mongodb 129520840 nov 15 22:37 mongos
````

### Respuesta Javi

Hola Bieito,

muy interesante pregunta!

Verás, no hay que confundir usuarios del sistema operativo con usuarios de la base de datos. Son dos cosas distintas que casi nunca están relacionadas. Cuando ejecutas un juego no esperas que tu usuario del ordenador aparezca como un perfil del juego. Son dos cosas distintas.

El usuario del sistema operativo (mongodb) es el encargado de ejecutar la base de datos desde un punto de vista de sistema operativo, es decir, con permisos para acceder al hardware, prioridades de ejecución, permisos de acceso a disco, etc.

Si has instalado mongoDB mediante repositorio o con un deb, docker o cualquier otra cosa "automatizada" te habrá creado automáticamente un usuario mongodb y un servicio que arranca la base de datos usando ese usuario.

Al listar los procesos en ejecución verás una instancia de mongodb cuyo propietario (el que la ha lanzado) es mongodb. Como sabes , mongodb quiere escribir en disco tanto sus datos como los logs por lo que hay que asegurarse que el usuario mongodb pueda llegar a esas carpetas. No es habitual dejar las carpetas de mongo dentro de la carpeta de ningún usuario porque es "raro". Lo habitual es dejar los datos en alguna de las carpetas del sistema a las que todos tenemos acceso como por ejemplo "/opt". Yo lo he propuesto así para pelearnos con los permisos. :-)

El truco para estas cosas es jugar con los grupos.

El ejemplo que pongo en clase cuando tengo que explicar estas cosas es el siguiente:

Imagina que en el instituto absolutamente todas las puertas tienen control de acceso. Sería bastante lio indicar explícitamente en cada puerta quien puede pasar y quien no. Solo imagina el trabajo que daría una nueva alta o una baja... habría que actualizar los permisos en todas las puertas!

La solución está en los grupos. Inicialmente yo, usuario Javi solo pertenezco al grupo Javi pero fácilmente puedo pertenecer a otros grupos que me permitirán usar sus privilegios. En uno de los primeros grupos que nos metemos los usuarios es en el grupo "sudo" que nos permite tener permisos administrativos.

Historicamente aún se conservan grupos por defecto dentro de los sistemas linux que dan una buena pista de lo que dejaban hacer como por ejemplo mail, news, fax, floppy o games. Imagina instalar todos los juegos con el usuario games. Después simplemente habría que añadir tu usuario y el mío al grupo games para poder jugar.

Volviendo al ejemplo. En mi identificación del instituto pondrá que soy profe y hombre. En tu identificación del instituto pondrá que eres alumno y hombre.

Cuando yo quiera entrar en la sala de profes podré porque pertenezco al grupo con permisos. En problema lo tendré cuando quiera entrar al baño de mujeres porque allí no tengo permisos.

Vamos a complicar un poco los baños. Imagina que en el centro tenemos baños mixtos pero que dentro, unos retretes están reservados para chicos, otros para chicas y otro adaptado. En este caso la puerta del baño tendría que ser configurada para que permita el paso a cualquiera.

Otro ejemplo, imagina una empresa grande. Tiene sentido que los empleados no tengan acceso total a todas las instalaciones y podrán hacerlo en la medida del grupo al que pertenzcan.

En un equipo informático que hace de servidor es altamente probable (y recomendable) que los procesos tengan un usuario. Tener el usuario mongodb solo para ejecutar la base de datos es extremadamente beneficioso para detectar un problema porque solo hay que buscar qué está haciendo este usuario. Si alguna vez has abierto el administrador de tareas verás que todos los procesos activos siempre tienen a su lado el propietario que los ha lanzado. Por lo tanto, si alguna vez MongoDB no arranca, da problemas de escritura, rechaza conexiones,... será necesario buscar que está haciendo este usuario.

Si todo en el sistema lo hacemos con un único usuario será bastante estudiar el problema porque no será fácil ver si un proceso en ejecución viene de algo relacionado con mongo o no.

Ahora que está claro que hay que utilizar usuarios para "administrar e identificar" los procesos en ejecución, vamos a entender lo de los grupos.

La base de datos es propiedad del usuario (y grupo) mongodb. Si tu usuario bieto quiere lanzar algún comando de mongo como por ejemplo mongosh deberemos añadir bieito al grupo mongodb (y asegurarnos que el grupo mongodb tenga los mismos permisos que el propietario mongodb)

Cuando bieito trate de ejecutar mongosh por ejemplo, el sistema operativo comprobará por orden:
¿Es el propietario? NO
¿Pertenece al grupo? SI
¿Tiene permiso de grupo para [leer|escribirejecutar] SÍ

...y te dejará ejecutar mongosh (o cualquier otro) sin problema

Ahora veamos esta situación especial que os planteo cuando os pido que los datos estén dentro de vuestra carpeta personal. En esta ocasión quiero que te pongas en el punto de vista del usuario mongodb....

El sistema está arrancando y root inicia el servicio mongod.service duante el arranque. Este servicio está configurado para ejecutar mongodb con el usuario mongodb así que este usuario entra en acción. En el mismo arranque el usuario mongodb debe llegar a la ruta des ejecutable de mongo y para ello tiene que pasar por la carpeta de un tal bieito. Por defecto las carpetas personales no permiten el paso de otros usuario... Opciones:
1.- Dar permisos de ejecución (para atravesar) en la parte de "otros". De esta manera, cuando mongo intentara entrar a tu carpeta, el sistema operativo preguntaría:
¿Es el propietario? NO
¿Pertenece al grupo? NO
Entonces es de los otros, ¿tiene permiso para wrx? SÍ y entonces entraría

Este enfoque tiene un problema de seguridad y es que mi usuario javi también podría entrar en tu carpeta personal.

2.- Añadir el usuario mongodb al grupo bieito y asegurarse que los permisos del grupo permiten pasar.

La secuencia de preguntas sería la misma... no es el propietario pero sí pertenece al grupo por lo que lo dejaría entrar. Este escenario está mejor protegido. Mi usuario javi no podría entrar en tu carpeta porque ni es propietario ni pertence al grupo bieito (se entiende que la parte de otros estaría ---) No es una mala solución, de hecho es la que busco en esta práctica! pero no es la optima porque el usuario mongodb tendría acceso a todas tus carpetas...

3.- Tal vez la solución donde todo queda absolutamente atado sea crear un nuevo grupo, por ejemplo, bieitocompartido. Con chown asignamos ese grupo a tu carpeta personal (pero no a las subcarpetas que seguirían siendo bieito) De esta manera, si metes a mongodb en el grupo bieitocompartido podría entrar a tu carpeta personal sin poder ver ni entrar al resto. Tú siempre entrará con los permisos de propietario así que no tendrás problemas.

Con la estructura de carpetas que tienes para mongo habría que asignar también permisos de este estilo, jugando con los grupos.

En resumen, tendrás que meter a bieito en el grupo de mongodb para que pueda ejecutar mongosh y mongoimport. Y tendrás que añadir al usuario mongodb al grupo bieito para que pueda llegar, escribir y ejecutar en esas carpetas.

Hasta aquí lo relacionado con el sistema operativo

---

Ahora lo relacionado con la base de datos.

Es habitual en las bases de datos que usen permitan usar como usuario de la base de datos uno que se llame igual que el del sistema operativo. Pasa también con las conexiones ssh. Si tu intentas hacer una conexion ssh a otro equipo solo poniendo su ip, ssh intentará loguearse en el equipo remoto con el usuario bieito. Si en la máquina remota existe un usuario con este nombre se conectará sin problemas. Quiere esto decir que el bieito de tu máquina es el mismo usuario que el bieito de la máquina remota? no.

En mongo pasa lo mismo, te puedes identificar en la base de datos usando el mismo nombre que tienes en el sistema operativo pero a todos los efectos (contraeña, permisos) son usuarios distintos.

De todas formas, en este curso no hemos tocado el tema de los usuarios en las bases de datos. Por defecto mongo no tiene activada la autenticación de usuarios así que siempre te estás conectando con el usuario root que tiene todos los permisos.

Si quieres profundizar en el tema de los usuarios y sus roles en mongos puedes consultar la documentación en https://www.mongodb.com/docs/manual/reference/built-in-roles/#std-label-database-administration-roles

En general, las bases de datos siguen un patrón muy parecido a los permisos del sistema operativo. En mongodb debes crear roles con los permisos que consideres y serán el equivalente a los grupos del sistema operativo. Después, a cada usuario le asignas el role que quieras y con ello le darás los permisos sobre las bases de datos.

Ánimo!

Un saludo, Javi
