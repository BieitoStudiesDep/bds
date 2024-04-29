#### 6.- Montar disco de datos
>
>>[!my-terminal]-  comandos
>>
>>```bash wrap
>># ver dispositivos
>>lsblk
>>
>># particionar
>>sudo fdisk /dev/vdb
>># p ==> ver info
>># g ==> tabla de particiones gpt
>># n ==> nueva particion [enter] , valores por defecto
>># w ==> escribir cambios
>>
>># dar formato
>>sudo mkfs.ext4 /dev/sdb1
>>
>># crear carpeta de montaje
>>mkdir discogrande
>>
>># persistencia 
>>sudo nano /etc/fstab
>># añadimos
>># ruta disco | ruta de montaje | sist. ficheros | opciones | que se compruebe|orden de comprobación
>># /dev/sdb1   /home/hdfs-admin/discogrande ext4  defaults 0 0
>>
>>sudo reboot # reiniciamos para que se monte el disco
>>lsblk # en el ultimo parametro nos indica en que ruta esta montado el disco
>>
>>```
>
>>[!my-folder]-  fstab
>>`sudo nano /etc/fstab`
>>
>> - Persistencia del montage de disco
>> - Al iniciar el equipo se monta el disco de manera automatizada
>>
>> |ruta de disco|ruta de montaje|sistema de ficheros|opciones de lectura / escritura|que se compruebe|orden de comprobación|
>> |:-:|:-:|:-:|:-:|:-:|:-:|
>> |/dev/sdb1|/home/hdfs-admin/discogrande|ext4|defaults|0|0|-|-|
>
>>```bash title:"lsblk ouput" fold wrap
>>NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
>>loop0    7:0    0     4K  1 loop /snap/bare/5
>>loop1    7:1    0 266,6M  1 loop /snap/firefox/3836
>>loop2    7:2    0  74,2M  1 loop /snap/core22/1122
>>loop3    7:3    0   497M  1 loop /snap/gnome-42-2204/141
>>loop4    7:4    0  91,7M  1 loop /snap/gtk-common-themes/1535
>>loop5    7:5    0  12,3M  1 loop /snap/snap-store/959
>>loop6    7:6    0  40,4M  1 loop /snap/snapd/20671
>>loop7    7:7    0   452K  1 loop /snap/snapd-desktop-integration/83
>>sda      8:0    0   100G  0 disk 
>>├─sda1   8:1    0     1M  0 part 
>>├─sda2   8:2    0   513M  0 part /boot/efi
>>└─sda3   8:3    0  99,5G  0 part /var/snap/firefox/common/host-hunspell
>>                                 /
>>sdb      8:16   0   500G  0 disk 
>>└─sdb1   8:17   0   500G  0 part /home/hdfs-admin/discogrande
>>sr0     11:0    1  1024M  0 rom  
>>```
