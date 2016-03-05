FROM cassandra:2.2.5

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

# create the directory that is going to accomodate the app (data and configuration)
RUN mkdir -p /app
RUN mkdir -p /app/data

# get the benchflow database schema
RUN  apt-get update \
     && apt-get install -y wget \
     && wget -q -O /app/data/database.cql https://github.com/benchflow/benchflow/raw/dev/database_schemas/cassandra/benchflow.cql \
     && apt-get -y remove --purge wget \
     && apt-get -y autoremove \
     && rm -rf /var/lib/apt/lists/*

COPY bin/initialize-entrypoint.sh /app/initialize-entrypoint.sh
RUN chmod +x /app/initialize-entrypoint.sh

# copy custom configurations
COPY conf/cassandra.yaml /etc/cassandra/cassandra.yaml

ENTRYPOINT ["/app/initialize-entrypoint.sh"]

# it seems that if we override the entrypoint then wen also need to define again the default command
CMD ["cassandra","-f"]