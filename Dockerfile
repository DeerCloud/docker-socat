FROM alpine:3.8 AS builder

LABEL maintainer="metowolf <i@i-meto.com>"

ENV VERSION 1.7.3.2

COPY ./patches /patches

RUN apk upgrade \
    && apk add build-base openssl-dev readline-dev linux-headers \
    && wget http://www.dest-unreach.org/socat/download/socat-$VERSION.tar.gz \
    && tar xzvf socat-$VERSION.tar.gz \
    && cd socat-$VERSION \
    && patch -i /patches/netdb-internal.patch \
    && patch -i /patches/use-linux-headers.patch \
    && ./configure \
    && make \
    && make install


FROM alpine:3.8

LABEL maintainer="metowolf <i@i-meto.com>"

ENV LISTEN_PORT 8000
ENV FORWARD_HOST=
ENV FORWARD_PORT=

EXPOSE $LISTEN_PORT/tcp
EXPOSE $LISTEN_PORT/udp

COPY --from=builder /usr/local/bin/* /usr/local/bin/

RUN apk add --no-cache \
    $(scanelf --needed --nobanner /usr/local/bin/* \
    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    | sort -u)

COPY entrypoint.sh /
ENTRYPOINT ["sh", "/entrypoint.sh"]
