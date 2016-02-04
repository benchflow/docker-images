#!/bin/bash
set -e

#Get the actual container IP on the network
ip=`ifconfig eth0 | grep "inet addr:" | cut -d : -f 2 | cut -d " " -f 1`
#Update the localhost to the actual container IP on the network
#We cannot direclty edit /ets/hosts with sed: https://github.com/smdahlen/vagrant-hostmanager/issues/136
sed -r 's/127.0.0.1(([[:space:]]\+)|\t)localhost/'$ip' localhost/g' /etc/hosts > /etc/hosts.new
cat /etc/hosts.new > /etc/hosts
rm /etc/hosts.new