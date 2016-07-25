FROM minio/minio:RELEASE.2016-07-13T21-46-05Z

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

ENV MINIO_CONF_FOLDER /home/minio/.minio

#TODO: at some point we should optimize this, now we are just adding bash for more easly use the scripts.
#      the same applies to sed, wget
#TODO: cleanup
RUN apk --update add bash sed wget

COPY config/config.json $MINIO_CONF_FOLDER/config.json

COPY bin/docker-entrypoint.sh /docker-entrypoint.sh

COPY bin/initialize-entrypoint.sh /initialize-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh /initialize-entrypoint.sh

ENTRYPOINT  ["/docker-entrypoint.sh"]
CMD         ["server","/data"]