FROM testdasi/debian-buster-slim-base:latest-amd64

ADD cloudflared /tmp
COPY ./install.sh /
EXPOSE 53/tcp 53/udp

# install cloudflared
RUN cd /tmp \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && apt install ./cloudflared-stable-linux-amd64.deb \
    && rm -f ./cloudflared-stable-linux-amd64.deb \
    && /bin/bash /install.sh \
    && rm -f /install.sh

CMD cloudflared --config /etc/cloudflared/config.yml
