FROM amd64/debian:buster-slim

# Preps
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install nano sudo dnsutils

# install cloudflared
RUN cd /tmp \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && apt install ./cloudflared-stable-linux-amd64.deb \
    && rm -f ./cloudflared-stable-linux-amd64.deb \
    && useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/cloudflared
# clean cloudflared config
RUN mkdir -p /etc/cloudflared \
    && rm -f /etc/cloudflared/config.yml

# add cloudflared config
ADD cloudflared /tmp
RUN cd /tmp \
    && mkdir -p /etc/cloudflared \
    && cp -n ./config.yml /etc/cloudflared/ \
    && rm -f ./config.yml

CMD cloudflared --config /etc/cloudflared/config.yml
