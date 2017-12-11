## Dockerfile for gitit
FROM debian:stretch
MAINTAINER Tim Skirvin "tskirvin@killfile.org"

ENV DEBIAN_FRONTEND noninteractive

# make the "en_US.UTF-8" locale
RUN apt-get update \
    && apt-get install -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENV GITIT_VERSION 0.12.1.1+dfsg-6+b3

## install gitit
RUN apt-get update \
    && apt-get install -y --no-install-recommends mime-support gitit=$GITIT_VERSION \
    && rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /data
EXPOSE 5001
CMD ["gitit", "-f", "/data/gitit.conf"]
