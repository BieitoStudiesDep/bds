#### install-hadoop-3.4.0

```bash
cd ~ 
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz
ls -la

# descomprimir
tar -xzf hadoop-3.4.0.tar.gz
ls -la
rm -rf hadoop-3.4.0.tar.gz

# renombrar a hadoop
mv hadoop-3.4.0 hadoop
ls -la

# ruta de archivos de configuración
ls ~/hadoop/etc/hadoop/
# ruta de archivos de binarios
ls ~/hadoop/bin
ls ~/hadoop/sbin

# añadir al PATH los binarios de hadoop
sudo nano /etc/environment
# PATH= [..]:/home/admin/hadoop/bin:/home/admin/hadoop/sbin
# HADOOP_HOME="/home/admin/hadoop/"

# reinicio
sudo reboot
env
```

📁sudo nano /etc/environment

```bash
# PATH= [..]:/home/hdfs-admin/hadoop/bin:/home/hdfs-admin/hadoop/sbin
# JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# HADOOP_HOME="/home/hdfs-admin/hadoop"
```
