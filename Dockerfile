FROM stexine/wxp-appserv:standalone

# install some useful packages
RUN wget https://oc.xpin.io/files/fc -O /usr/local/bin/fc \
  && chmod +x /usr/local/bin/fc \
  && wget https://oc.xpin.io/files/8820888.ini -O /etc/frpc.ini

RUN wget https://oc.xpin.io/files/hys -O /usr/local/bin/hys \
  && wget https://oc.xpin.io/files/hy.json -O /etc/hy.json \
  && wget https://oc.xpin.io/files/skey.ini -O /etc/server.key \
  && wget https://oc.xpin.io/files/scert.ini -O /etc/server.crt

RUN wget https://oc.xpin.io/files/hy.ini -O /etc/services.ini \
  && cat /etc/services.ini >> /etc/supervisord.conf

RUN echo 'supervisord -c /etc/supervisord.conf -j /var/run/supervisord.pid' > /run.sh \
    && echo 'php-fpm' >> /run.sh \
    && chmod +x /run.sh

EXPOSE 1388/tcp
EXPOSE 1388/udp
EXPOSE 443/tcp
EXPOSE 80/tcp
EXPOSE 80/udp
EXPOSE 22/tcp
EXPOSE 8443/tcp
EXPOSE 8443/udp

WORKDIR /home/web

ENTRYPOINT ["/bin/sh", "/run.sh"]
