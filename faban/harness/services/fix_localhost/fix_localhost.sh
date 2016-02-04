#!/bin/bash
set -e

#Get the actual container IP on the network

#If on TUTUM, get the IP of the container on the TUTUM network
if [[ $TUTUM_IP_ADDRESS ]]; then
	ip=$TUTUM_IP_ADDRESS
#If using network --net="host" we pass the actual IP of the host
elif [[ $HOST_IP ]]; then
	ip=$HOST_IP
#Else we get the IP of the current container
else
	ip=`ifconfig eth0 | grep "inet addr:" | cut -d : -f 2 | cut -d " " -f 1`
fi
#Update the localhost to the actual container IP on the network
#We cannot direclty edit /ets/hosts with sed: https://github.com/smdahlen/vagrant-hostmanager/issues/136
sed -r 's/127.0.0.1(([[:space:]]\+)|\t)localhost/'$ip' localhost/g' /etc/hosts > /etc/hosts.new
cat /etc/hosts.new > /etc/hosts
rm /etc/hosts.new