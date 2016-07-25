#!/bin/bash
set -e
 
echo "Getting the Minio client..."

wget --no-check-certificate -O /bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc.${MINIO_CLIENT_VERSION}
chmod 755 /bin/mc

echo "Starting Minio to initialize it..."

chown -R minio:minio /data
/usr/bin/gosu minio /usr/bin/minio server /data &

echo "Waiting for Minio to be ready..."

sleep 5

echo "Initialising the buckets..."

#TODO: make a script taking care of a file to take care of the bucket definition centralized in a file that should be placed in https://github.com/benchflow/benchflow
mc mb $MINIO_ALIAS/runs
mc mb $MINIO_ALIAS/benchmarks

echo "Configuring access policies..."

mc policy both $MINIO_ALIAS/runs
mc policy both $MINIO_ALIAS/benchmarks

echo "Killing Minio..."
pkill -f minio
sleep 5

echo "Minio initialised..."

#TODO: remove the minio client and configurations

# execute the base image entrypoint in the context of the current shell
source /entrypoint.sh