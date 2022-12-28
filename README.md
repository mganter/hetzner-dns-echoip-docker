# hetzner-dns-echoip-docker

This tool updates a record on hetzner-dns to your own publicly addressable IP.

## How to use

```bash
docker run -d \
    -e HETZNER_DNS_TOKEN="<your-token>" \
    -e IPV4_RECORD_ID="<ipv4-record-id>" \
    -e IPV6_RECORD_ID="<ipv6-record-id>" \
    ghcr.io/mganter/hetzner-dns-echoip:latest
```

## Environment Variables

| Name              | Required | Description                                                                                            |
|-------------------|----------|--------------------------------------------------------------------------------------------------------|
| HETZNER_DNS_TOKEN | yes      | The token this script uses to interact with hetzner-dns                                                |
| IPV4_RECORD_ID    | np       | The ipv4 record that should be updated                                                                 |
| IPV6_RECORD_ID    | yes      | The ipv6 record that should be updated                                                                 |
| ECHOIP_ENDPOINT   | no       | This overrides the default [echoip](https://github.com/mpolden/echoip) endpoint. (https://ifconfig.co) |

