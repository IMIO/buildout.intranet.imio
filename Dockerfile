FROM docker-staging.imio.be/intranet/cache:latest
RUN pip install --upgrade pip
RUN mkdir /home/imio/intranet
COPY docker-entrypoint.sh /
COPY *.cfg /home/imio/intranet/
COPY Makefile /home/imio/intranet/
COPY *.sh /home/imio/intranet/
COPY *.txt /home/imio/intranet/
RUN chown imio:imio -R /home/imio/intranet/ && chown imio:imio /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh
WORKDIR /home/imio/intranet
USER imio
RUN ln -fs prod.cfg buildout.cfg &&\
    ./bootstrap.sh -c prod.cfg
USER root
RUN apt-get remove -y gcc python-dev &&\
    apt-get autoremove -y &&\
    apt-get clean
USER imio
ENV ZEO_HOST db
ENV ZEO_PORT 8100
ENV HOSTNAME_HOST local
ENV PROJECT_ID imio
EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD /home/imio/intranet/bin/instance console
