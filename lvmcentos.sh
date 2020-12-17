#lvm.sh nẳm trong /usr/local/bin
#Crontjob
#@reboot sh /usr/local/bin/lvm.sh
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
