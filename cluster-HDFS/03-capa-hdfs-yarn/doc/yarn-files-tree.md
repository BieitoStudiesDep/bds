
|archivos conf | color|
|-|:-:|
|hadoop|<mark class="htr-forestgreen">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</mark>|
|yarn|<mark class="htr-teal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</mark>|
/home/hdfs-admin/hadoop/etc/hadoop/
<mark class="htr-teal">├── mapred-site.xml</mark> // `yarn`
<mark class="htr-teal">└── yarn-site.xml</mark> // `yarn`
 ==├── capacity-scheduler.xml== // 
 <mark class="htr-forestgreen">├── core-site.xml</mark> // `hadoop` identifica al nodo principal
<mark class="htr-forestgreen">├── decomisados</mark> // `hadoop` archivo que crearemos nostros
<mark class="htr-forestgreen">├── hdfs-site.xml</mark>  // `hadoop` configuramos las propiedades de  [[nodo-datanode]] y [[nodo-namenode]]
<mark class="htr-forestgreen">├── workers</mark>  // `hadoop` indicaremos los nombres de los [[nodo-datanode]]
 ├── configuration.xsl
 ├── container-executor.cfg
 ├── hadoop-env.cmd
 ├── hadoop-env.sh
 ├── hadoop-metrics2.properties
 ├── hadoop-policy.xml
 ├── hadoop-user-functions.sh.example
 ├── hdfs-rbf-site.xml
 ├── httpfs-env.sh
 ├── httpfs-log4j.properties
 ├── httpfs-site.xml
 ├── kms-acls.xml
 ├── kms-env.sh
 ├── kms-log4j.properties
 ├── kms-site.xml
 ├── log4j.properties
 ├── mapred-env.cmd
 ├── mapred-env.sh
 ├── mapred-queues.xml.template
 ├── shellprofile.d
 │   └── example.sh
 ├── ssl-client.xml.example
 ├── ssl-server.xml.example
 ├── user_ec_policies.xml.template
 ├── yarn-env.cmd
 ├── yarn-env.sh
 ├── yarnservice-log4j.properties
