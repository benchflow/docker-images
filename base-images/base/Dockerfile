FROM chapdev/chaperone-alpinebase:1.0.13-U14

MAINTAINER Vincenzo FERME <info@vincenzoferme.it>

# Remove sample application from chaperone.d
RUN rm /apps/chaperone.d/200-userapp.conf
RUN rm /apps/bin/sample_app

# create the directory that is going to accomodate the app
RUN mkdir -p /app
# enable chaperone to work on the following directories
RUN chown -R runapps: /apps /app

ENTRYPOINT ["/usr/local/bin/chaperone"]