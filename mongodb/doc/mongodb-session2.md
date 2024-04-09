
[📽️ Parte 2. Sesión presencial MongoDB](https://www.youtube.com/watch?v=1-DUzN1SqAg)

<iframe width="560" height="315" src="https://www.youtube.com/embed/1-DUzN1SqAg?si=RdaMW1pD9XrlN8Vu" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

En este vídeo continuamos con el repaso de la sesión presencial sobre MongoDB. Anteriormente vimos las consultas usando el comando find. En este vídeo nos centramos en las consultas de agregación usando el comando aggregate. El único parámetro que pasamos a este comando es un pipeline en forma de array de documentos donde cada documento es una etapa. Un pipeline es una secuencia de etapas donde la salida de una etapa es la entrada de la siguiente. Antes de explicar las consultas de agregado me paro a explicar un problema habitual y es el de trabajar directamente (e incómodamente) en el servidor. Esto es necesario para la instalaciuón y la configuración pero para el uso de MongoDB es mucho más amigable un cliente gráfico. Por ello, al principio del vídeo configuro un nuevo nodo solo como cliente mongosh y desde allí hago todo. Las consultas de agregados consisten en ir aplicando etapas. En el vídeo veremos algunas de las etapas más usadas con las que podrás resolver la mayoría de las consultas. Todas las etapas tienen su uso concreto y alguna particularidad. Lo importante es tener claro qué hace cada una y que los resultados serán las entradas de la siguiente etapa.

Enlace al tutorial: [https://abalarbox.edu.xunta.gal/index...](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbGdxT2IyQXdVb1E2LXBLSnNTaUhPU2U5NG9jUXxBQ3Jtc0trZGJEalNQbHFNMTcxOFFmcHVQOWF6NWRvbkNhSElFYnF3dF9aZTJjRWlHaFVpUlVsNjNQcGJWb2pyblRNUC1nZkFCMFBwdmRwdVdzSkIxcHZuN19wdmtiRVRjVHJBZzkweHBTdWdxSFN3bks4aHhycw&q=https%3A%2F%2Fabalarbox.edu.xunta.gal%2Findex.php%2Fs%2FjZ4Bb3jwJLeX62m&v=1-DUzN1SqAg)


```js
// muestra de sales.js
[
  {
    _id: ObjectId("5bd761dcae323e45a93ccfeb"),
    saleDate: ISODate("2015-02-23T09:53:59.343Z"),
    items: [
      {
        name: "binder",
        tags: ["school", "general", "organization"],
        price: Decimal128("20.08"),
        quantity: 1,
      },
      {
        name: "pens",
        tags: ["writing", "office", "school", "stationary"],
        price: Decimal128("23.08"),
        quantity: 4,
      },
      {
        name: "backpack",
        tags: ["school", "travel", "kids"],
        price: Decimal128("82.73"),
        quantity: 2,
      },
      {
        name: "printer paper",
        tags: ["office", "stationary"],
        price: Decimal128("15.98"),
        quantity: 3,
      },
      {
        name: "notepad",
        tags: ["office", "writing", "school"],
        price: Decimal128("27.24"),
        quantity: 4,
      },
      {
        name: "notepad",
        tags: ["office", "writing", "school"],
        price: Decimal128("27.7"),
        quantity: 5,
      },
      {
        name: "pens",
        tags: ["writing", "office", "school", "stationary"],
        price: Decimal128("59.86"),
        quantity: 5,
      },
      {
        name: "binder",
        tags: ["school", "general", "organization"],
        price: Decimal128("27.33"),
        quantity: 9,
      },
      {
        name: "notepad",
        tags: ["office", "writing", "school"],
        price: Decimal128("13.59"),
        quantity: 1,
      },
    ],
    storeLocation: "Seattle",
    customer: { gender: "F", age: 45, email: "vatires@ta.pe", satisfaction: 3 },
    couponUsed: false,
    purchaseMethod: "In store",
  },
];
```


```bash
// conexion desde cliente != del host

//importar datos
mongoimport --db ejemplos --collection ventas --file sales.json --host 192.168.0.26

// conexion moongosh
mongosh --host 192.168.0.26

// comandos
show databases
use ejemplos
show collections
```

```js
// agregate

// $match es similar al find
// cliente mayor de 70
db.ventas.aggregate([
	{
		$match : {"customer.age" : {$gt : 70}}
	}
])

// $ne distinto a ...
db.ventas.aggregate([
	{
		$match : {
			"customer.age" : {$gt : 70},
			"storeLocation" : "Seattle",
			"purchaseMethod" : {$ne : "In store"}
		}
	}
])

// sus items contienen los elementos

// $ne distinto a ...
db.ventas.aggregate([
	{
		$match : {
			"items.name" : { 
				$all : ["notepad", "pens", "laptop"]
			}
		}
	}
])



```

[ minuto 15:31](https://youtu.be/1-DUzN1SqAg?si=kSzAjLJNP6i5yule&t=931)

