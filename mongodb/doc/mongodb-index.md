<!-- cSpell:ignore zxvf -->
<!-- markdownlint-disable MD041 MD032 MD029-->

## configurar servidor mongodb

Para levantar mongodb necesitamos el siguiente entorno
**_[instalación]_**

1. instalar servidor mongodb
   - 1.1. instalar mongodb custom
   - 1.2. instalar mongodb repo
   - 1.3. instalar mongodb docker

**_[entorno]_**

2. Entorno
   - 2.1. definir en el PATH los binarios `mongod` y `mongos`
   - 2.2. definir una ruta `mongo` donde se guarden los binarios y los archivos de configuración del usuario.
   - 2.3. definir una ruta y un archivo donde mongodb guarde los `logs`
   - 2.4. definir una ruta y un directorio donde mongodb guarde los `datos`
   - 2.5. podemos indicar otras opciones
     - ips admitidas para la conexión con el servidor

**_[usuario]_**

3. Definir un usuario que ejecute mongodb-server
   - 3.1 crear un usuario mongodb para ejecutar el servidor
   - 3.2 `(grupo sudo)` para poder ejecutar los binarios `mongod` y `mongos` mediante (sudo) y (mongod) para podrá lanzar ejecutar el servidor
   - 3.3 con permisos de `r-w` y acceso en las carpetas y ficheros del entorno (`📄 log, 📁 datos , 📁 mongo`)

**_[lanzar servidor]_**

4. Mediante `mongod` podemos lanzar el servidor
   - 4.1 requisitos
     - 4.1.1 memoria ram minima de 4G
     - 4.1.1 usuario con grupo (sudo) los permisos de entorno requerido `r-w` del entorno (`📄 log, 📁 datos , 📁 mongo`)
     - 4.1.2 indicarle a mongod los parámetros de configuración (usuario, `📄 log, 📁 datos , 📁 mongo`, ips validas)
       -4.1.3 tener los binarios `mongod` y `mongos` definidos en el path
   - 4.2 ejecución
     - 4.2.1 comando `mongod`
     - 4.2.1 comando `mongod` y archivo de conf
       - `mongod --config /etc/mongod.conf &`
     - 4.2.1 creando un servicio que automatice comando `mongod` y archivo de conf
       - `sudo systemctl start mongod.service` # iniciar servicio
       - `sudo systemctl status mongod.service` # ver estado del servicio
       - `sudo systemctl enable mongod.service` # (persistencia) iniciar servicio al inicio del sistema
