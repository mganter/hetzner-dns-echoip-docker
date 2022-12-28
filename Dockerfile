FROM alpine:3

ENV HETZNER_DNS_TOKEN ""
ENV ZONE_ID ""
ENV RECORD_ID ""
ENV RECORD_NAME ""

ENV ECHOIP_ENDPOINT "https://ifconfig.co/"

RUN apk add curl jq

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh