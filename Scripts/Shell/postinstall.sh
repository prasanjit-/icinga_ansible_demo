#!/bin/bash
#Post installation tasks

#Import icinga DB
docker exec -i -t mydb mysql -proot -uroot < ../Icinga/IcingaDB.sql

#Install icinga plugins & start daemon-
cd /tmp/
rm -rf monitoring-plugins monitoring-plugins-2.1.2
tar xzvf monitoring-plugins-2.1.2.tar.gz ; cd monitoring-plugins-2.1.2/
./configure --prefix=/tmp/ && make && make install
cd /tmp/libexec
find . -print | cpio -dumpv /usr/lib64/nagios/plugins
icinga -d /etc/icinga/icinga.cfg > /dev/null 2>&1
icinga --show-scheduling /etc/icinga/icinga.cfg
