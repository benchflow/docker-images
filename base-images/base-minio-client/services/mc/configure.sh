#!/bin/bash
set -e

echo "Configuring the Minio client..."

#TODO: remove, here for testing purposes and because the mc is the only tool to interact with Minio that is up to date with the server
sudo /app/mc config host add $MINIO_ALIAS $MINIO_HOST $MINIO_ACCESSKEYID $MINIO_SECRETACCESSKEY

echo "Minio initialised..."