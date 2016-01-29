#!/bin/bash
set -e

# escaping forward slash for sed
MINIO_ACCESSKEYID_ESCAPED=$(echo ${MINIO_ACCESSKEYID//\//\\\/})
MINIO_SECRETACCESSKEY_ESCAPED=$(echo ${MINIO_SECRETACCESSKEY//\//\\\/})

sed -i 's/$MINIO_ACCESSKEYID/'${MINIO_ACCESSKEYID_ESCAPED}'/' "$MINIO_CONF_FOLDER/config.json"
sed -i 's/$MINIO_SECRETACCESSKEY/'${MINIO_SECRETACCESSKEY_ESCAPED}'/' "$MINIO_CONF_FOLDER/config.json"

# execute the initialize-entrypoint in the context of this shell
source /initialize-entrypoint.sh