| archivo | dirección |descripción|
|:-:|:-:|-|
|[[mapred-site.xml]]| sudo nano ~/hadoop/etc/hadoop/mapred-site.xml|definimos: <ul><li>el nodo que actua como  [[yarn-resurcemanage]]</li><li>servicios como [[mapreduce_shuffle]]</li></ul>|
|[[yarn-site.xml]]| sudo nano ~/hadoop/etc/hadoop/yarn-site.xml |definimos: <ul><li>determinamos que usamos un sistema de almacenamiento distribuido</li><li>defiinimos las clases (java) que va a usar mapreducer</li></ul> |