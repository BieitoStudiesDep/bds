## MongoDB Tipo de datos

[documentación mongodb tipo de datos](https://www.mongodb.com/docs/mongodb-shell/reference/data-types/#objectid)

```
{
	# id de objeto
	_id: ObjectId("6114216907d84f537039191a"),
	# date
	
	boolean : 'true',
	s : 'string',
	number : 3,
	# Int32
	i: Int32("1"),
	l: Long("1"),
	d: Decimal128("1"),
	# Timestamp
	ts: Timestamp({ t: 1628709225, i: 2 })
}

```

### Fecha[![](https://www.mongodb.com/docs/mongodb-shell/assets/link.svg)](https://www.mongodb.com/docs/mongodb-shell/reference/data-types/#date "Enlace permanente a este encabezado")

`mongosh`proporciona varios métodos para devolver la fecha, ya sea como una cadena o como un `Date`objeto:

- `Date()`Método que devuelve la fecha actual como una cadena.

- `new Date()`constructor que devuelve un `Date`objeto usando el `ISODate()`contenedor.

- `ISODate()`constructor que devuelve un `Date`objeto usando el `ISODate()`contenedor.

### ID de objeto[![](https://www.mongodb.com/docs/mongodb-shell/assets/link.svg)](https://www.mongodb.com/docs/mongodb-shell/reference/data-types/#objectid "Enlace permanente a este encabezado")

`mongosh`proporciona la `ObjectId()`clase contenedora alrededor del [ID de objeto](https://www.mongodb.com/docs/manual/reference/bson-types/#std-label-objectid)tipo de datos. Para generar un nuevo ObjectId, utilice la siguiente operación en `mongosh`:

```
new ObjectId
```

### Marca de tiempo[![](https://www.mongodb.com/docs/mongodb-shell/assets/link.svg)](https://www.mongodb.com/docs/mongodb-shell/reference/data-types/#timestamp "Enlace permanente a este encabezado")

MongoDB utiliza un [Marca de tiempo BSON](https://www.mongodb.com/docs/manual/reference/bson-types/#timestamps)internamente en el[registro de operaciones](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-oplog). El `Timestamp`tipo funciona de manera similar al tipo Java Timestamp. Utilizar el[Fecha](https://www.mongodb.com/docs/mongodb-shell/reference/data-types/#std-label-mongo-shell-date-type)tipo para operaciones que involucran fechas.

Una `Timestamp`firma tiene dos parámetros opcionales.

```js
Timestamp( { "t": <integer>, "i": <integer> } )
```

| Parámetro | Tipo   | Por defecto                                                                                                  | Definición                                                                                                                                       |
| --------- | ------ | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `t`       | entero | Hora actual desde[Época UNIX .](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-unix-epoch) | Opcional. Un tiempo en segundos.                                                                                                                 |
| `i`       | entero | 1                                                                                                            | Opcional. Se utiliza para realizar pedidos cuando hay varias operaciones en un segundo determinado. `i`no tiene ningún efecto si se usa sin `t`. |
> unix epoch : January 1st, 1970 at 00:00:00 UTC. Commonly used in expressing time, where the number of seconds or milliseconds since this point is counted.
