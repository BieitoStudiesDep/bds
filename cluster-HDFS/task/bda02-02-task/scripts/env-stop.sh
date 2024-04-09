#!/bin/bash

# Definir la contraseña de sudo
nodopasw='BigData.,'

# Función para detener un nodo y apagar el sistema
detener_nodo_y_apagar() {
    ssh -tt hadoop@$1 << EOF
    hdfs --daemon stop datanode
    echo '$nodopasw' | sudo -S shutdown now
    exit
EOF
}

# Detener nodos y apagar sistema
detener_nodo_y_apagar bie1 &
detener_nodo_y_apagar bie2 &
detener_nodo_y_apagar bie3 &
detener_nodo_y_apagar bie4 &

# Esperar a que los comandos en paralelo se completen
wait