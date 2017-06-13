#!/bin/bash
#Post installation tasks
cd ~/icinga_ansible_demo/Icinga/
#Import icinga DB
sleep 30
docker exec -i mydb mysql -proot -uroot < IcingaDB.sql

#Install icinga plugins & start daemon-
cd /tmp/
rm -rf monitoring-plugins monitoring-plugins-2.1.2
tar xzvf monitoring-plugins-2.1.2.tar.gz ; cd monitoring-plugins-2.1.2/
./configure --prefix=/tmp/ && make && make install > /dev/null 2>&1
cd /tmp/libexec
find . -print | cpio -dumpv /usr/lib64/nagios/plugins
icinga -d /etc/icinga/icinga.cfg > /dev/null 2>&1
echo "Icinga Post Install Tasks Completed!"
