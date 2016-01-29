FROM benchflow/base-images:dev

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

RUN apk --update add wget && \
    wget -q --no-check-certificate -O /app/mc https://dl.minio.io/client/mc/release/linux-386/mc && \
    chmod +x /app/mc && \
    apk del --purge wget && \
    rm -rf /var/cache/apk/*

COPY ./services/100-minio-client-configure.conf /apps/chaperone.d/100-minio-client-configure.conf

COPY ./services/mc/configure.sh /configure-mc/configure.sh
RUN chmod +x /configure-mc/configure.sh