# hetzner-dns-echoip-docker

This tool updates a record on hetzner-dns to your own ip.

## How to use

```bash
docker run -d \
    -e HETZNER_DNS_TOKEN="<your-token>" \
    -e ZONE_ID="<dns-zone-id>" \
    -e RECORD_ID="<to-be-updated-record-id>" \
    -e RECORD_NAME="<record-name>" \
    ghcr.io/mganter/hetzner-dns-echoip:latest
```

## Environment Variables

| Name              | Required | Description                                                                                            |
|-------------------|----------|--------------------------------------------------------------------------------------------------------|
| HETZNER_DNS_TOKEN | yes      | The token this script uses to interact with hetzner-dns                                                |
| ZONE_ID           | yes      | The zone that your record resides in                                                                   |
| RECORD_ID         | yes      | The record that should be updated                                                                      |
| RECORD_NAME       | yes      | The name of your record. eg. 'nextcloud'.                                                              |
| ECHOIP_ENDPOINT   | no       | This overrides the default [echoip](https://github.com/mpolden/echoip) endpoint. (https://ifconfig.co) |

