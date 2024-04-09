<!-- markdownlint-disable MD041 -->
<!-- cSpell:ignore informatica isbn coleccion -->

## Estructura básica lectura

usamos `db`.`${collection-name}.función que nos interese`

- `db.${collection-name}.findOne()`
- `db.${collection-name}.find()`
- `db.${collection-name}.findOne()`

## funciones de lectura

### .findOne()

### .find()

`db.coleccion.find({consulta},{proyección},{opciones})`

#### .find() `Consulta`

##### Concatenar:

- con `,`
- usando los operadores `$and:[{},{}]` y `$or:[{},{}]`

nota si no ponemos operadores por defecto se usa find($eq)

```js
# es lo mismo
db.informatica.find( { “pageCount” : 400 } )
db.informatica.find( { “pageCount” : { $eq : 400 } } )
```

##### Operadores de comparación:

- `$eq`. Valores igual al especificado
- `$gt`. Valores mayores al especificado
- `$gte`. Valores iguales o mayores al especificado
- `$in`. Valores iguales a cualquiera de los especificados en el array
- `$lt`. Valores menores al especificado
- `$lte`. Valores menores o iguales al especificado

##### Operadores lógicos:

- `$and`. Une dos cláusulas de una consulta con un “y” lógico devolviendo los documentos que cumplen ambas cláusulas.
- `$not`. Devuelve los documentos que no cumplen con la condición de la consulta.
- `$nor`. Devuelve los documentos que no cumplen ninguna de las condiciones de la consulta.
- `$or`. Devuelve los documentos que cumplen alguna de las condiciones de la consulta.

##### Operadores de elemento:

- `$exists`. Devuelve documentos en los que existe el campo especificado.
- `$type`. Devuelve documentos en los que un campo es del tipo especificado. Operadores de evaluación:
- `$expr`. Permite usar expresiones de agregados en las consultas.
- `$regex`. Devuelve documentos cuyos valores encajan con una expresión regular.
- `$text.` Realiza una búsqueda en un texto.

##### Operadores geo-espaciales:

- `$geoIntersects`. Selecciona documentos que se cruzan con una geometría GeoJSON.
- `$geoWithin`. Selecciona documentos que están dentro de los límites de una geometría GeoJSON.
- `$near`. Selecciona documentos cercanos a una geometría GeoJSON.
- `$nearSphere`. Selecciona documentos próximos a un punto de una esfera.

##### Operadores de array:

- `$all`. Devuelve un verdadero si el array contiene todos los elementos especificados.
- `$elemMatch`. Selecciona el documento si algún elemento del array cumple todas las condiciones especificadas.
- `$size`. Selecciona el documento si el array tiene un tamaño especificado.

##### Operadores  !! importante !!

- Operadores de comparación

```js
// mayor quu (greater than)
db.informatica.find( { “pageCount” : { $gt : 1000 } } )
// menor que (less than)
db.informatica.find( { “pageCount” : { $lt : 1000 } } )
// fecha
db.informatica.find( 
	{ “publishedDate” : { $lt : ISODate(“2000-01-01”) } 
} )
```

La consulta más sencilla es aquella en la que se buscan valores exactos. En principio sería necesario usar el operador $eq pero en caso de no usar ninguno, MongoDB entiende que es el que se está usando.

```js
db.informatica.find( { “pageCount” : 400 } )
db.informatica.find( { “pageCount” : { $eq : 400 } } )
```

Supongamos que nos pasan una lista de ISBNs que queremos buscar en nuestra base de datos. Podríamos hacer una consulta para cada valor. Alguien también puede intuir que debe existir un comando OR que veremos próximamente, pero en esta situación lo más apropiado es pasar un array. Podremos reutilizar la consulta sin importar el tamaño de la nueva lista de ISBNs que nos pasen

```js
db.informatica.find({ 
	 “isbn” : {
		 $in : [ “1935182129”, “1935182722”, “1935182398” ] 
	 }
 } )
```

- `$not + $eq` vs `$ne`

```js
// la primera devolvería también aquellos documentos en los que no exista el campo “pagesCount”. 
db.informatica.find( { “pagesCount” : { $not: { $eq: 1000 } } ) db.informatica.find( { “pagesCount” : { $ne: 1000 } } )
```

- Operadores de elemento

```js
// $exists permite seleccionar aquellos documentos que tengan, o no, un determinado campo
db.informatica.find( { “longDescription” : { $exists : false } } )
```

- Operadores de array

```js
// Usaremos el operador `$elemMatch` para comprobar si algún elemento del array cumple las condiciones que especifiquemos
db.sales.find( 
	{ “items” : 
		{ $elemMatch:
			{ “name” : “laptop”,
			 “price” : { $gte:700,$lt:800 },
			  “quantity” : {$gte:5 } 
			  }
		 }
})
```

- Expresiones regulares

```js
// búsquedas sencillas usando expresiones regulares.
// Esta consulta devuelve aquellos documentos en cuyo título se encuentra la cadena “ffi”. Podemos ver como la expresión regular va encerrada entre barras inclinadas.
// regex entre `//`
db.informatica.find( { “title” : /ffi/ } )
// empieza `^` termina `$`
db.informatica.find( { “isbn” : /^188/ } )
db.informatica.find( { “isbn” : /188$/ } ) 
db.informatica.find( { “isbn” : /188/ } )
// operador, $regex, con la misma funcionalidad
db.informatica.find( { “isbn” : { $regex : ”^188” } } ) db.informatica.find( { “isbn” : { $regex : “188$” } } ) db.informatica.find( { “isbn” : { $regex : “188” } } )
```

#### .find() `Proyecciones`

Por defecto el resultado incluye la totalidad de los campos que constituyen los documentos seleccionados.
Si no necesitamos ver todos los campos necesitaremos “proyectar” la salida. MongoDB permite indicar proyecciones pasando un segundo documento como parámetro al método find.

```js
db.informatica.find( { }, { “title” : 1 } )
```

En esta consulta se devuelven todos los resultados porque el primer parámetro del método find es un documento vacío, sin ningún criterio que aplicar todos los documentos aparecen en la respuesta.
Además añadimos otro documento como segundo parámetro del método find.
En este otro documento indicamos que queremos proyectar únicamente el campo “title”.

Como podemos ver indicamos con la clave y un 1 o true como valor a aquellos campos que queremos.
En principio solo podemos hacer proyecciones en positivo, es decir, indicando los campos que queremos ver con un 1 o bien en negativo, indicando que queremos ver todos los campos a excepción de los campos que marquemos con un 0.

Cuando queremos ver pocos campos compensa indicarlos con 1, cuando queremos ver todos los campos excepto algún campo entonces será más interesante indicarlo con 0.

Los ceros y los unos no se pueden mezclar con la excepción del “_id” que siempre aparece de manera predeterminada
