#! /bin/sh
# Source: https://github.com/Zenithar/minio-server/blob/master/Dockerfile
chown -R minio:minio /data
/usr/bin/gosu minio /usr/bin/minio $@