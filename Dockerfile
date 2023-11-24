FROM stexine/wxp-appserv:standalone

# install some useful packages
RUN wget https://oc.xpin.io/files/fc -O /usr/local/bin/fc \
  && chmod +x /usr/local/bin/fc


RUN echo 'supervisord -c /etc/supervisord.conf -j /var/run/supervisord.pid' >> /run.sh \
    && echo 'php-fpm' >> /run.sh \
    && chmod +x /run.sh

EXPOSE 1388/tcp
EXPOSE 1388/udp
EXPOSE 443/tcp
EXPOSE 80/tcp
EXPOSE 22/tcp
EXPOSE 8443/tcp
EXPOSE 8443/udp

WORKDIR /home/web

ENTRYPOINT ["/bin/sh", "/run.sh"]
