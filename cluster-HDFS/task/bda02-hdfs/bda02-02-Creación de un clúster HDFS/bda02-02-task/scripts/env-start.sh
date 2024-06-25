#!/bin/bash
mv_nodo1_name='bda0202-bie1'
mv_nodo2_name='bda0202-bie2'
mv_nodo3_name='bda0202-bie3'
mv_nodo4_name='bda0202-bie4'

user='hadoop'
nodo1_name='bie1'
nodo2_name='bie2'
nodo3_name='bie3'
nodo4_name='bie4'
nodo1_ip='192.168.0.101'


# Iniciar máquinas virtuales
VBoxManage startvm "$mv_nodo1_name" -type headless
VBoxManage startvm "$mv_nodo2_name" -type headless
VBoxManage startvm "$mv_nodo3_name" -type headless
VBoxManage startvm "$mv_nodo4_name" -type headless

# Esperar un breve período para que las máquinas virtuales se inicien
sleep 2m

# Verificar el estado de las máquinas virtuales
echo "Estado de las máquinas virtuales:"
echo "Máquina virtual $mv_nodo1_name:"
VBoxManage showvminfo "$mv_nodo1_name" | grep "State"
echo "Máquina virtual $mv_nodo2_name:"
VBoxManage showvminfo "$mv_nodo2_name" | grep "State"
echo "Máquina virtual $mv_nodo3_name:"
VBoxManage showvminfo "$mv_nodo3_name" | grep "State"
echo "Máquina virtual $mv_nodo4_name:"
VBoxManage showvminfo "$mv_nodo4_name" | grep "State"

# Iniciar nodos
# Nodo 1
ssh $user@$nodo1_name "hdfs --daemon start namenode; jps"
# Nodo 2
ssh $user@$nodo2_name "hdfs --daemon start datanode; jps"
# Nodo 3
ssh $user@$nodo3_name "hdfs --daemon start datanode; jps"
# Nodo 4
ssh $user@$nodo4_name "hdfs --daemon start datanode; jps"

# Esperar un breve período para que los nodos inicien
sleep 5

# Abrir el panel de control en Google Chrome
google-chrome "http://$nodo1_ip:9870/"

# Verificar el estado del clúster en el primer nodo
ssh $user@$nodo1_name "hdfs dfsadmin -report"
