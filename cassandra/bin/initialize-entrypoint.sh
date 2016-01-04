#!/bin/bash
set -e

echo "Starting Casandra to initialize it..."
cassandra
echo "Waiting for Cassandra to be ready..."
sleep 10
echo "Initialising the database..."
cqlsh -f /app/data/database.cql
echo "Killing Cassandra..."
pkill -f cassandra
sleep 10
echo "Cassandra database initialised..."

# execute the base image entrypoint in the context of the current shell
source /docker-entrypoint.sh