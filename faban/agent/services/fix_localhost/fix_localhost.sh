#!/bin/bash
set -e

#Get the actual container IP on the network

#If on TUTUM, get the IP of the container on the TUTUM network
if [[ $TUTUM_IP_ADDRESS ]]; then
	#strips the trailing /N+
	TUTUM_IP_ADDRESS=`echo $TUTUM_IP_ADDRESS | sed -r 's/\/([0-9]+)//'`
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
#If on TUTUM, we also need to update the local IP of the container
if [[ $TUTUM_CONTAINER_HOSTNAME ]]; then
	CONTAINER_LOCAL_IP=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
    sed -ri 's/'$CONTAINER_LOCAL_IP'(([[:space:]]\+)|\t)'$TUTUM_CONTAINER_HOSTNAME'/'$ip' '$TUTUM_CONTAINER_HOSTNAME'/g' /etc/hosts.new
fi

cat /etc/hosts.new > /etc/hosts
rm /etc/hosts.new