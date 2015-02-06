#!/bin/bash

[ $1 ] && user=$1 || user=alex

useradd -m -d /home/${user} -s /bin/bash -G sudo ${user}
mkdir /home/${user}/.ssh
wget https://raw.githubusercontent.com/ashilokhvostov/main/master/id_rsa.pub -O /home/${user}/.ssh/authorized_keys

docker pull ashilokhvostov/zabbix:latest

chmod 700 /home/${user}/.ssh
chmod 600 /home/${user}/.ssh/authorized_keys
chown -R ${user}:${user} /home/${user}/.ssh
echo "${user}	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

mkdir -p /opt/mysql_zabbix
chown -R 27:sudo /opt/mysql_zabbix

apt-get update
apt-get install -y vtun mc

wget https://raw.githubusercontent.com/ashilokhvostov/main/master/vtun -O /etc/default/vtun
wget https://raw.githubusercontent.com/ashilokhvostov/main/master/vtund.conf -O /etc/vtund.conf

/etc/init.d/vtun restart
