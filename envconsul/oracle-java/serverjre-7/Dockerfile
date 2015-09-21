#Base image reference: https://github.com/jeanblanchard/docker-java
FROM jeanblanchard/java:serverjre-7

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

ENV ENVCONSUL_VERSION v0.5.0
ENV ENVCONSUL_VERSION_NUMBER 0.5.0

RUN apk --update add wget bash && \
    wget -q --no-check-certificate -O /tmp/consul.tar.gz https://github.com/hashicorp/envconsul/releases/download/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION_NUMBER}_linux_amd64.tar.gz && \
    tar -xzvf /tmp/consul.tar.gz -C /usr/bin/ && \
    mv /usr/bin/envconsul_${ENVCONSUL_VERSION_NUMBER}_linux_amd64/envconsul /usr/bin/envconsul && \
    apk del --purge wget && \
    rm -rf /var/cache/apk/* /tmp/* /usr/bin/envconsul_${ENVCONSUL_VERSION_NUMBER}_linux_amd64/ /var/tmp/* *.gz
  
ENV ENVCONSUL_CONFIG /etc
  
COPY ./config/envconsul-config.hcl ${ENVCONSUL_CONFIG}/envconsul-config.hcl
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
