<!-- markdownlint-disable MD041 -->

### [mongoimport]

```bash
# copiamos los archivos a /tmp
docker cp ./sales.json mongo:/tmp/sales.json
# Successfully copied 4.87MB to mongo:/tmp/sales.json
docker cp ./books.json mongo:/tmp/books.json
# Successfully copied 539kB to mongo:/tmp/books.json
# nos conectamos a un terminal
docker exec -it mongo bash
# importamos sales.json
mongoimport --db=SBD02-02-bieito --collection=bieitoventas --file=/tmp/sales.json
# importamos books.json
mongoimport --db=SBD02-02-bieito --collection=bieitolibros --file=/tmp/books.json

```
