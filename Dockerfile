ARG FRM='testdasi/debian-buster-slim-base'
ARG TAG='latest'

FROM ${FRM}:${TAG}
ARG FRM
ARG TAG
ARG TARGETPLATFORM

ADD cloudflared /tmp
COPY ./install.sh /
RUN /bin/bash /install.sh \
    && rm -f /install.sh

EXPOSE 53/tcp 53/udp

CMD cloudflared --config /etc/cloudflared/config.yml
