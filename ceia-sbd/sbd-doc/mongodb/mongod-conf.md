<!-- markdownlint-disable MD041 -->

📄 /etc/mongod.conf

```bash

# 📄 /etc/mongod.conf
# Network interfaces.
net:
  port: 27017
  bindIp: 0.0.0.0
# Ruta de almacenamiento de datos
storage:
   dbPath: /home/bieito/datos

# Ruta de registro de logs
systemLog:
   destination: file
   path: "/home/bieito/log/mongo.log"
   logAppend: true
```

<!-- markdownlint-enable MD041 -->
