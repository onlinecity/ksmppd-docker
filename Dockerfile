FROM alpine:3.5

RUN apk add --no-cache ca-certificates bash subversion curl \
  build-base libxml2-dev mariadb-dev libtool musl-dev linux-headers \
  libtool bison
ADD https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt \
  /etc/ssl/certs/lets-encrypt-x3-cross-signed.pem
COPY svn-trust /etc/subversion/servers
ADD https://github.com/kneodev/ksmppd/archive/1.0.2.tar.gz /
RUN tar xvzpf 1.0.2.tar.gz
RUN mkdir /ksmppd-1.0.2/kannel-svn-trunk && \
  ln -s /usr/share/libtool/build-aux/ltmain.sh \
  /ksmppd-1.0.2/kannel-svn-trunk/ltmain.sh
RUN ln -s /usr/include/unistd.h /usr/include/sys/unistd.h
RUN cd ksmppd-1.0.2 && ./bootstrap.sh && make

COPY config/ksmppd.conf /etc/kannel/ksmppd.conf

WORKDIR /ksmppd-1.0.2
ENTRYPOINT ["smpp/ksmppd" ]
CMD [ "/etc/kannel/ksmppd.conf" ]
