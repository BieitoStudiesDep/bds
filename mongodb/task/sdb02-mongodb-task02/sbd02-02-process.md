<!-- cSpell:ignore -->
<!-- markdownlint-disable MD041 -->

![sbd02-02-link](sbd02-02-link.md)

### install docker

```bash
cd ~
# instalar llave publica
wget https://download.docker.com/linux/ubuntu/gpg
# desarmarla pasar de texto plano a
sudo gpg -o /usr/share/keyrings/docker.gpg --dearmor gpg
# ver version de linux
lsb_release -a
# No LSB modules are available.
# Distributor ID: Ubuntu
# Description:    Ubuntu 20.04.6 LTS
# Release:        20.04
# Codename:       focal
sudo nano /etc/apt/sources.list.d
##### añadimos a /etc/apt/sources.list.d
deb [ arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable
#####
sudo apt update # forzar a apt que lea este nuevo repo
sudo apt update && sudo apt upgrade && sudo apt install docker-ce
sudo systemctl start docker  # activar servicio
sudo systemctl status docker.service  #verificar servicio
sudo usermod -aG docker bieitostudies  # añadimos usuario bieitostudies a grupo docker
sudo usermod -aG docker bieito # añadimos usuario bieito a grupo docker
```

#### docker imagen mongodb

```bash
docker ps
docker run --name mongo -d mongodb/mongodb-community-server
docker exec -it mongo bash
# copiamos el archivo de configuración a local
docker cp mongo:/etc/mongod.conf.orig .
# editamos el archivo de configuración para que se puedan conectar todas las ips 0.0.0.0
nano mongod.conf.orig
# # network interfaces
# net:
#   port: 27017
#   bindIp: 0.0.0.0

# paramos contenedor
docker stop mongo
# eliminamos el contenedor
docker rm mongo
# vuelvo a crear el contenedor redirigiendo los puertos
docker run -p 27017:27017 --name mongo -d mongodb/mongodb-community-server
# sobre escribo la configuración de mongo
docker cp ./mongod.conf.orig mongo:/etc/mongod.conf.orig
# actualizo el contenedor
docker stop mongo
docker start mongo
# me conecto
mongo "mongodb://localhost:27017"
```
