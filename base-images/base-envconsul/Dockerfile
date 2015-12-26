FROM benchflow/base-images:dev

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

ENV ENVCONSUL_VERSION v0.6.0
ENV ENVCONSUL_VERSION_NUMBER 0.6.0

RUN apk --update add wget bash unzip && \
    wget -q --no-check-certificate -O /tmp/consul.zip https://github.com/hashicorp/envconsul/releases/download/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION_NUMBER}_linux_amd64.zip && \
    unzip -d /usr/bin/ /tmp/consul.zip && \
    apk del --purge wget unzip && \
    rm -rf /var/cache/apk/* /tmp/* /usr/bin/envconsul_${ENVCONSUL_VERSION_NUMBER}_linux_amd64/ /var/tmp/* *.zip 
  
ENV ENVCONSUL_CONFIG /envconsul
  
COPY ./services/envconsul/config/envconsul-config.hcl ${ENVCONSUL_CONFIG}/envconsul-config.hcl
COPY ./services/envconsul/configure.sh /envconsul/configure.sh
RUN chmod +x /envconsul/configure.sh
COPY ./services/envconsul/start.sh /envconsul/start.sh
RUN chmod +x /envconsul/start.sh
COPY ./services/envcp/update.sh /envcp/update.sh
RUN chmod +x /envcp/update.sh

COPY ./services/100-envconsul-configure.conf /apps/chaperone.d
COPY ./services/200-envconsul-envcp.conf /apps/chaperone.d
# create the directory that is going to accomodate the app
RUN mkdir -p /app
# enable chaperone to work on the following directories
RUN chown -R runapps: /apps /app /envconsul