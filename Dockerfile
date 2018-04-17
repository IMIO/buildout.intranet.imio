ARG uid="1000"
FROM docker-staging.imio.be/intranet/cache:${uid}
RUN mkdir /home/imio/imio-intranet
COPY *.cfg /home/imio/imio-intranet/
COPY Makefile /home/imio/imio-intranet/
COPY *.py /home/imio/imio-intranet/
COPY scripts /home/imio/imio-intranet/scripts
RUN chown imio:imio -R /home/imio/imio-intranet/
WORKDIR /home/imio/imio-intranet
USER imio
RUN /usr/bin/python bootstrap.py -c prod.cfg &&\
    make buildout-prod
USER root
RUN apt-get remove -y gcc python-dev &&\
    apt-get autoremove -y &&\
    apt-get clean
USER imio
ENV ZEO_HOST db
ENV ZEO_PORT 8100
ENV HOSTNAME_HOST local
ENV PROJECT_ID imio