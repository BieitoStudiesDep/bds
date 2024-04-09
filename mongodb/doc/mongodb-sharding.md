[📽️ Sharding mongodb](https://www.youtube.com/watch?v=chO3I1vtUAo)

<iframe width="560" height="315" src="https://www.youtube.com/embed/lggFEWd9SiI?si=3wZkAi1GDUaKdtQa" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

> [!Description]
>
> En este vídeo explicamos qué es y como funciona la fragmentación en MongoDB.
> Una de las soluciones de MongoDB al escalado vertical consiste en fragmentar colecciones que crecen demasiado.
> Esta fragmentación consiste en guardar documentos de esa colección en distintos nodos atendiendo a una clave de fragmentación que puede estar compuesta de uno o varios campos. De esta manera se trocea la colección agrupando documentos en función del valor de la clave usada.
> Para una mejor gestión de la colección que ahora estará distribuida en varios nodos, MongoDB usa "chunks" o "trozos" de has 128 megabytes.
> Estos trozos son fácilmente desplazables a otros nodos menos saturados.
> Elegir una buena clave de fragmentación es fundamental ya que hacerlo mal puede acabar en chunks que no sean divisibles (jumbo chunks) que puede llegar a colapsar el nodo.
> Ejerciendo como una especie de tabla de ficheros tenemos a los config servers que son los encargados de llevar el registro y tomar las decisiones de en qué chunk y en qué nodo se encuentra un determinado documento.
> Tanto los nodos shard como los nodos config server deben ser primarios de un conjunto de réplica. Esto les permitirá mejorar su rendimiento en cuanto a alta disponibilidad añadiendo secundarios que colaboren en las lecturas.
> La configuración de los nodos shard y config server es sencilla, simplemente hay que modificar el puerto de escucha, indicar qué función desempeñan dentro del clúster sharding y configurar el nombre del conjunto de réplicas.
> La interfaz con los clientes remotos se realiza mediante nodos mongos.
> Realmente mongos es un proceso pequeño encargado de cachear al servidor de configuración y capaz de enviar las consultas al nodo shard adecuado. Un nodo mongos también es fácil de configurar porque el puerto es el mismo que el de un proceso mongod normal y simplemente hay que indicar las ruta del servidor de configuración. El último paso consiste en añadir cada uno de los nodos shard al config server a través de un mongos. Al final del vídeo se ven un par de comandos que ayudan a conocer el estado del clúster de sharding y comprobar si la clave de sharding elegida está distribuyendo adecuadamente los documentos en chunks y shards.
>
> Enlace a la guía: [https://abalarbox.edu.xunta.gal/index...](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa1N3UEs5bDNjdGQ0ZC03ZDhIOVdiXzNvcXNEQXxBQ3Jtc0tub29JNFlyNzFsQXVOeFdLYTRIdzVLMF8xR3VRVlVkaDVYcm51dmNJUzQ3eHh4S0oyaHBRbXF6OERqUmVaUGlLdTNPVnBFOVdVWmtTdVBuQ1Y1cDRFdnZTR0hWUlg5YnVjUWxyNC1IUlQtaV9DQUpRTQ&q=https%3A%2F%2Fabalarbox.edu.xunta.gal%2Findex.php%2Fs%2Fkm6rysyHD8dr5rx&v=lggFEWd9SiI)

[Sharding-MongoDB.pdf](sbd02-mongodb-sharding.pdf)

