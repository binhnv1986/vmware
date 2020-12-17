#lvm.sh nẳm trong /usr/local/bin
#Crontjob
#@reboot sh /usr/local/bin/lvm.sh
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
