#### install java08

```bash
sudo apt update && sudo apt upgrade
sudo apt install openjdk-8-jdk
# en la salida del comando 
# ver la ruta del sistema de los binarios de java
# update-alternatives: ____
sudo nano /etc/environment
# PATH= [..]
# JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# comprobar variables del sistema 
env
```