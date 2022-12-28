FROM alpine:3

ENV HETZNER_DNS_TOKEN ""
ENV IPV4_RECORD_ID ""
ENV IPV6_RECORD_ID ""

ENV ECHOIP_ENDPOINT "https://ifconfig.co/"

RUN apk add curl jq

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh