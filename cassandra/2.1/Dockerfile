FROM cassandra:2.1.9

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

# enable authentication and authorisation
RUN sed -ri ' \
		s/^(authenticator:).*/\1 org.apache.cassandra.auth.PasswordAuthenticator/; \
	' "$CASSANDRA_CONFIG/cassandra.yaml"

RUN sed -ri ' \
		s/^(authorizer:).*/\1 org.apache.cassandra.auth.CassandraAuthorizer/; \
	' "$CASSANDRA_CONFIG/cassandra.yaml"