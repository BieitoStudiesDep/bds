<!-- markdownlint-disable MD041 -->

📄 /etc/systemd/system/mongod.service [sudo]

```bash
Description=MongoDB Database Server
Documentation=https://docs.mongodb.org/manual
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=mongodb
Group=mongodb
WorkingDirectory=/home/bieito/mongo/bin
Environment="OPTIONS=--config /etc/mongod.conf"
ExecStart=/home/bieito/mongo/bin/mongod $OPTIONS

[Install]
WantedBy=multi-user.target

```
