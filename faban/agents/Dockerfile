FROM benchflow/envconsul:v0.5.0_serverjre-7

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

ENV FABAN_VERSION 1.3.1
#Faban will be installed in the ${FABAN_ROOT}/faban directory
#this has to be the same location as the harness location on the master machine
#so it will be probably better to pass this as an argument to the container
ENV FABAN_ROOT /
ENV FABAN_HOME ${FABAN_ROOT}faban


#TODO: change to download from the benchflow faban repository and build from there (while developing)
#RUN apk --update add wget && \
#	wget -q --no-check-certificate -O /tmp/faban.tar.gz http://faban.org/downloads/faban-kit-${FABAN_VERSION}.tar.gz && \
#	mkdir -p ${FABAN_ROOT}/ && \
#	tar -xzvf /tmp/faban.tar.gz -C ${FABAN_ROOT}/ && \
#	apk del --purge wget && \
#    rm -rf /var/cache/apk/* /tmp/* /var/tmp/* *.gz

COPY ./faban ${FABAN_ROOT}
COPY ./tmp/faban-agent.tar.gz ${FABAN_ROOT}faban-agent.tar.gz

#I don't know if these are necessary or not
#Tomcat logs
VOLUME ${FABAN_HOME}/master/logs
#Tomcat conf
VOLUME ${FABAN_HOME}/master/conf
#Faban output
VOLUME ${FABAN_HOME}/output
#Faban benchmarks
VOLUME ${FABAN_HOME}/benchmarks
#Faban config
VOLUME ${FABAN_HOME}/config
#Faban logs
VOLUME ${FABAN_HOME}/logs
#Faban services
VOLUME ${FABAN_HOME}/services

#Faban uses ports in the 9980 - 9999 range. Currently these are the list of ports and their functionality:
#9980 - Faban HTTP server
EXPOSE 9980
#9981 - Agent bootstrap
EXPOSE 9981
#9984 - Faban HTTP server shutdown
EXPOSE 9984
#9985 - Faban HTTP server coyote connector
EXPOSE 9985
#9988 - Runtime stats (currently not enabled by Faban)
#9998 - RMI registry
EXPOSE 9998
#9999 - Faban logging
EXPOSE 9999
    
#We use CMD because we don't want to override the ENTRYPOINT of the base image
#but let's start the agent instead
CMD ["sh","-c","${FABAN_HOME}/master/bin/startup.sh"]
#CMD ["sh","-c","${FABAN_HOME}/bin/agent"]
