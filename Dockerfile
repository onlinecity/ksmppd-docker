FROM alpine:3.5

ADD https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt \
  /etc/ssl/certs/lets-encrypt-x3-cross-signed.pem
COPY svn-trust /etc/subversion/servers
ADD https://raw.githubusercontent.com/onlinecity/wait-for-it/\
master/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

RUN apk add --no-cache ca-certificates bash subversion \
  libxml2 pcre musl hiredis curl mariadb-client-libs \
  libxml2-dev pcre-dev build-base libtool musl-dev bison mariadb-dev \
  hiredis-dev \
  && curl -s -L https://github.com/kneodev/ksmppd/archive/1.0.2.tar.gz \
  -o /tmp/ksmppd.tar.gz \
  && tar xvzpf /tmp/ksmppd.tar.gz \
  && mkdir /ksmppd-1.0.2/kannel-svn-trunk \
  && ln -s /usr/share/libtool/build-aux/ltmain.sh \
  /ksmppd-1.0.2/kannel-svn-trunk/ltmain.sh \
  && ln -sf /usr/include/poll.h /usr/include/sys/poll.h \
  && ln -s /usr/include/unistd.h /usr/include/sys/unistd.h \
  && cd ksmppd-1.0.2 && ./bootstrap.sh && make \
  && cp smpp/ksmppd /usr/local/bin/ \
  && apk del libxml2-dev pcre-dev build-base libtool musl-dev bison \
  hiredis-dev openssl-dev subversion mariadb-dev \
  && rm -rf /ksmppd-1.0.2 && rm -rf /tmp/*

COPY config/ksmppd.conf /etc/kannel/ksmppd.conf

ENTRYPOINT ["/usr/local/bin/ksmppd" ]
CMD [ "/etc/kannel/ksmppd.conf" ]
