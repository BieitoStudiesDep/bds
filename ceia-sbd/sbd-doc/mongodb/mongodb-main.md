<!-- cSpell:ignore mongoimport -->

<!-- markdownlint-disable MD041 -->

## mongodb simple queries

https://www.youtube.com/watch?v=p15IN6dZ1cw
[mongoDB-Operadores](https://www.mongodb.com/docs/manual/reference/operator/query/)

![[mongodb-features]]

![[mongodb-comand-basic]]

![[mongodb-data-types]]

![[mongodb-operation-insert]]

![[mongodb-operation-read-simple]]


ISODate()

```shell
# base de datos sin esquemas
#ver el nombre de todas las bases de datos
show databases
# ir a la base de datos
use ${databasename}
# dentro de la bd ver colecciones
show collections
# consulta findOne 
db.${collection-name}.findOne()
# consulta find
db.coleccion.find({consulta},{proyección},{opciones})
# consulta "where"
# proyeccion "select"
# operadores de comparación



```