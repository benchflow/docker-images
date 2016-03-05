#!/bin/bash
set -e

echo "Starting Casandra to initialize it..."
cassandra
echo "Waiting for Cassandra to be ready..."
sleep 20
echo "Initialising the database..."
cqlsh -f /app/data/database.cql
echo "Killing Cassandra..."
pkill -f cassandra
sleep 20
echo "Cassandra database initialised..."

# execute the base image entrypoint in the context of the current shell
source /docker-entrypoint.sh