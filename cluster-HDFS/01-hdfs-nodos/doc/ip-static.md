#### Add static IP

```bash
# configurar ips
sudo nano /etc/netplan/01-network-manager-all.yaml
sudo netplan try
```

>[!my-folder]-  01-network-manager-all.yaml
>`sudo nano /etc/netplan/01-network-manager-all.yaml`
> con `ip a` detectamos la interfaz de red `enp0s3`
> definimos
>
> - una ip estatica `192.168.0.101/24`
> - una puerta de enlace `192.168.0.1`
> - unos dns `192.168.0.1` y `8.8.8.8`
>
>```bash
># Let NetworkManager manage all devices on this system
>network:
>  version: 2
>  ethernets:
>     enp0s3:
>       addresses:
>        - 192.168.0.101/24
>       routes:
>       - to: default
>         via: 192.168.0.1
>       nameservers:
>        addresses:
>          - 192.168.0.1
>          - 8.8.8.8
>```