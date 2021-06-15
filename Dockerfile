FROM ubuntu:latest

ARG VERSION=0.1.18
ENV TUNNELTO_VERSION=${VERSION}

ENV DASHBOARD_PORT=8080

RUN apt-get update && apt-get install -y \
    curl \
    tini

ADD https://github.com/agrinman/tunnelto/releases/download/${TUNNELTO_VERSION}/tunnelto-linux.tar.gz /tmp/tunnelto.tar.gz
RUN tar -xf /tmp/tunnelto.tar.gz -C /bin \
    && rm /tmp/tunnelto.tar.gz

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tunnelto"]

EXPOSE ${DASHBOARD_PORT}:${DASHBOARD_PORT}
