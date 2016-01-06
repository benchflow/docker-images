FROM wurstmeister/kafka:0.8.2.1

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

COPY ./bin/start-kafka.sh /usr/bin/start-kafka.sh
RUN chmod +x /usr/bin/start-kafka.sh

#Additional fixes because of errors (strange since the FROM image install them)
RUN apt-get update \
    && apt-get install -y jq \
    && rm -rf /var/lib/apt/lists/*