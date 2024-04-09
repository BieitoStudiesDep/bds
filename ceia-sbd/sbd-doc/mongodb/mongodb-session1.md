[📽️ Parte 1. Sesión presencial MongoDB](https://youtu.be/fFIMYSa9JwU?si=dR1rNibGLyqntir7)
<iframe width="560" height="315" src="https://www.youtube.com/embed/fFIMYSa9JwU?si=Ew66CpOy75MOke29" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

En este video se resume la primera parte de la sesión presencial en la que se trabajó con MongoDB. Aquí aprendimos a insertar nuevos documentos y leerlos aplicando algunas condiciones. En primer lugar se importan e insertan datos usando las funciones insertOne e insert. La parte importante del vídeo se centra en las consultas con el comando find. En especial el uso de operadores. Por último, se explica y se pone algún ejemplo de las proyecciones. Para alguno de los ejemplos se han usado los siguientes datos: 

```
show databases
use nombre
```


```
db.nombre.insertOne({"nombre" : "javi" })
```

```
b.ciudades.insertMany( [{ 
 "nombre":"Vigo",
 "provincia":"Pontevedra",
 "coordenadas":[42.235833,-8.726667],
 "superficie":109.06,
 "población":293652,
 "autoridad": {
  "nombre": "Abel Caballero",
  "partido":"PSdeG-PSOE" },
 "hermanada": ["Victoria de Durango","Lorient","Narsaq","Oporto","Buenos Aires","Caracas","Las Palmas","Celaya","Qingdao"],
 "actualizado":ISODate("2024-01-01")
},

{ 
 "nombre":"Pontevedra",
 "provincia":"Pontevedra",
 "coordenadas":[42.433611, -8.6475],
 "superficie":118.22,
 "población":82535,
 "autoridad": {
  "nombre": "Miguel Anxo Fernández Lores",
  "partido":"BNG" },
 "hermanada": ["San José","Santo Domingo", "Salvador de Bahía", "Merlo", "Barcelos", "Vila Nova de Cerveira", "Gondomar", "Naupacto"],
 "actualizado":ISODate("2024-01-01")
}
,
{ 
 "nombre":"Santiago de Compostela",
 "provincia":"A Coruña",
 "coordenadas":[42.883333,-8.53333],
 "superficie":220.01,
 "población":98687,
 "autoridad": {
  "nombre": "Goretti Sanmartín Rei",
  "partido":"BNG" },
 "hermanada": ["Córdoba","Santiago de Cali","Temuco","Buenos Aires","Cáceres","Qufu","Santiago de Cuba", "Pisa", "Asis", "Coímbra","Popayán"],
 "actualizado":ISODate("2024-01-01")
}
,
{ 
 "nombre":"Ourense",
 "provincia":"Ourense",
 "coordenadas":[42.33556,-7.86406],
 "superficie":85.20,
 "población":104250,
 "autoridad": {
  "nombre": "Gonzalo Pérez Jácome",
  "partido":"DO" },
 "hermanada": ["Vila Real", "Tialnepantla","Quimper","Ciudad Bolivar"],
 "actualizado":ISODate("2024-01-01")
}
,
{ 
 "nombre":"Lugo",
 "provincia":"Lugo",
 "coordenadas":[43.011667,-7.557222],
 "superficie":329.78,
 "población":98214,
 "autoridad": {
  "nombre": "Lara Méndez López",
  "partido":"PSdeG-PSOE" },
 "hermanada": ["Ferrol", "Dinan", "Viana do Castelo","Qinhuangdao"],
 "actualizado":ISODate("2024-01-01")
}
])
```

operacion atomica ???
.findOne()
.find() devuelve un  objeto  cursor , array de punteros a los documentos originales
se itera con `it` de 20 en 20
el cursor permite cursor.count() y cursor.limit(3)
IsoDate(año-mes-dia)
operadores
$eq
$gt
$lt
entre

```
# Poblacion entre 100000 y 110000

db.ciudades.find(
	{"poblacion" : { $gt: 100000 , $lt: 110000}}
)

db.ciudades.find(
	{$and : [
	 {"poblacion" : $gt: 100000 },
	 {"poblacion" : $lt: 110000 }
	]}
)
```

```
# Provincias Pontevedra o Ourense

db.ciudades.find(
	{"provincia" : { $in : ["Ourense","Pontevedra"] }}
)

db.ciudades.find(
	{$or : [
	 {"provincia" : "Ourense" },
	 {"provincia" : "Pontevedra" }
	]}
)
```

```
# documentos donde no exista el campo aeropuerto
db.ciudades.find(
	{"aeropuerto" : { $exists: false}}
)
```

```
# busqueda en el array
# $all tienen que darse todas las condicidones citadas

db.ciudades.find(
	{"hermanada" : { $all : ["Buenos Aires","Caracas"] }}
)
```


```
# ciudad cullo nomvbre empieza por abel

db.ciudades.find(
	{"autoridad.nombre" : /^Abel/}
)
```


```
# proyecciones, "select" filtramso los datos que queremos mostrar

db.ciudades.find(
	{},
	{"nombre":1 , "_id":0}
)

# añdir alias y campo calculado habporkm habitante por quilometro
db.ciudades.find(
	{},
	{
		"nombre":1 ,
		"alcalde":"$autiridad.nombre",
		"habporkm":{ $divide : [ "población" , "superficie" ] }
	}
)
```



Enlace al tutorial: [https://abalarbox.edu.xunta.gal/index...](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbWNYdjM1eHd2VUpCV0dKU0pHYVZVQldxbi1rUXxBQ3Jtc0tuNHJOU1J1ME0xVHlNRDh3SFVidzZIWk1OTi1DQ2VKcnRIdmNCQVJCdG5Rc19BaEVwaFlBNDUyYlhwYTVrcFVQZENILUZPeTJQWkFYMXVJU20tZzM1X0l3cTZwRFN0Tk9aUWRHWnRZQ0d4XzhFLUFwUQ&q=https%3A%2F%2Fabalarbox.edu.xunta.gal%2Findex.php%2Fs%2FjZ4Bb3jwJLeX62m&v=fFIMYSa9JwU)