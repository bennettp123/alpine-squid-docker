FROM library/alpine:3.7

RUN apk upgrade --no-cache \
 && apk add --no-cache \
        curl \
        openssl \
        squid \
 && rm -rf /var/cache/apk/*

COPY squid.conf /etc/squid/squid.conf

COPY squidwrapper.sh /usr/local/bin
CMD ["/usr/local/bin/squidwrapper.sh"]

