FROM spotify/kafka:latest

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>


COPY bin/initialize-entrypoint.sh /initialize-entrypoint.sh

RUN chmod +x /initialize-entrypoint.sh

ENTRYPOINT  ["/initialize-entrypoint.sh"]
CMD         ["supervisord", "-n"]