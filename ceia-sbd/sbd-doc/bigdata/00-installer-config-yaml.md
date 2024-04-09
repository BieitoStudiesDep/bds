```bash
sudo nano /etc/netplan/00-installer-config.yaml
```

📄 `/etc/netplan/00-installer-config.yaml` [root]

```bash
network:
  ethernets:
    enp0s3:
      addresses:
        - 192.168.0.51/24
      routes:
        - to: default
          via: 192.168.0.1
      nameservers:
        addresses:
          - 8.8.8.8
  version: 2
```

