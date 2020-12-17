# vmware
lvm.sh nẳm trong /usr/local/bin
#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

fdisk /dev/sda <<EOF
n
p
4


t
4
8e
w
EOF

partprobe
pvcreate /dev/sda4
vgextend ubuntu-vg /dev/sda4
lvextend -l +100%FREE /dev/ubuntu-vg/root /dev/sda4
resize2fs /dev/ubuntu-vg/root

rm -rf /var/spool/cron/crontabs/root




Voi Centos
#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

fdisk /dev/sda <<EOF
n
p
3


t
3
8e
w
EOF

partprobe
pvcreate /dev/sda3
vgextend centos /dev/sda3
lvextend -l +100%FREE /dev/centos/root /dev/sda3
xfs_growfs /dev/centos/root

rm -rf /var/spool/cron/root




Crontjob
@reboot sh /usr/local/bin/lvm.sh

Lvm.service nằm trong /etc/systemd/system
[Unit]
Description=My custom startup script
# After=network.target
# After=systemd-user-sessions.service
# After=network-online.target

[Service]
# User=spark
# Type=simple
# PIDFile=/run/my-service.pid
ExecStart=/usr/local/bin/lvm.sh start
# ExecReload=/home/transang/startup.sh reload
# ExecStop=/home/transang/startup.sh stop
# TimeoutSec=30
# Restart=on-failure
# RestartSec=30
# StartLimitInterval=350
# StartLimitBurst=10

[Install]
WantedBy=multi-user.target
