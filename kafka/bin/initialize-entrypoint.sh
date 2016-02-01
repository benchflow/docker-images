#!/bin/bash
set -e

echo "Starting Kafka to initialize it..."

supervisord

echo "Waiting for Kafka to be ready..."

sleep 30

echo "Initialising the topics..."

#TODO: make a script taking care of a file to take care of the topics definition centralized in a file that should be placed in https://github.com/benchflow/benchflow, and with better partition and replication-factor conf
$KAFKA_HOME/bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --topic mysqldump --partition 1 --replication-factor 1 --create
$KAFKA_HOME/bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --topic zip --partition 1 --replication-factor 1 --create
$KAFKA_HOME/bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --topic stats --partition 1 --replication-factor 1 --create
$KAFKA_HOME/bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --topic logs --partition 1 --replication-factor 1 --create

echo "Killing Kafka..."
pkill -f supervisord
sleep 5
pkill -f start-kafka.sh
sleep 10
ps aux | grep 'java' | awk '{print $2}' | cut -d " " -f 2 | xargs kill -9
sleep 10

echo "Kafka initialised..."