#!/bin/bash

# install cloudflared
if [[ ${TARGETPLATFORM} =~ "arm" ]]
then 
    cd /tmp \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.tgz \
    && tar -xvzf ./cloudflared-stable-linux-arm.tgz \
    && cp ./cloudflared /usr/local/bin \
    && rm -f ./cloudflared-stable-linux-arm.tgz \
    && echo "Cloudflared installed for arm due to tag ${TAG}"
else 
    cd /tmp \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && apt install ./cloudflared-stable-linux-amd64.deb \
    && rm -f ./cloudflared-stable-linux-amd64.deb \
    && echo "Cloudflared installed for amd64 due to tag ${TAG}"
fi
useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/cloudflared

# clean cloudflared config
mkdir -p /etc/cloudflared \
    && rm -f /etc/cloudflared/config.yml

# add cloudflared config
cd /tmp \
    && mkdir -p /etc/cloudflared \
    && cp -n ./config.yml /etc/cloudflared/ \
    && rm -f ./config.yml

# clean up
apt-get -y remove wget \
    && apt-get -y autoremove \
    && apt-get -y autoclean \
    && apt-get -y clean \
    && rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*
