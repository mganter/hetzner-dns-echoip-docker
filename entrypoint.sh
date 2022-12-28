#!/bin/sh
echo IPV4_RECORD_ID is $IPV4_RECORD_ID
echo IPV6_RECORD_ID is $IPV6_RECORD_ID
echo ECHOIP_ENDPOINT is $ECHOIP_ENDPOINT

set -e

while [ true ]
do
  if [ ! -z $IPV4_RECORD_ID ]; then 
    ipv4=$(curl -4s $ECHOIP_ENDPOINT)
    echo ipv4 in request is $ipv4

    ipv4_record=$(curl -s "https://dns.hetzner.com/api/v1/records/$IPV4_RECORD_ID" -H "Auth-API-Token: $HETZNER_DNS_TOKEN")
    ipv4_record_zone_id="$(echo $ipv4_record | jq -r '.record.zone_id')"
    ipv4_record_value="$(echo $ipv4_record | jq -r '.record.value')"
    ipv4_record_name="$(echo $ipv4_record | jq -r '.record.name')"
    ipv4_record_type="$(echo $ipv4_record | jq -r '.record.type')"

    echo ipv4 in record is $ipv4_record_value

    if [ "$ipv4_record_value" != "$ipv4" ]; then 
      echo records are not equal. Reconcile in progress..
      curl -s -X "PUT" "https://dns.hetzner.com/api/v1/records/$IPV4_RECORD_ID" \
        -H 'Content-Type: application/json' \
        -H "Auth-API-Token: $HETZNER_DNS_TOKEN" \
        -d "{\"value\":\"$ipv4\",\"ttl\": 60,\"type\":\"$ipv4_record_type\",\"name\":\"$ipv4_record_name\",\"zone_id\":\"$ipv4_record_zone_id\"}"
    else 
      echo records are equal.. nothing to do.
    fi
  else
    echo "IPV4 is disabled"
  fi

  if [ ! -z $IPV6_RECORD_ID ]; then 
    ipv6=$(curl -6s $ECHOIP_ENDPOINT)
    echo ipv6 in request is $ipv6

    ipv6_record=$(curl -s "https://dns.hetzner.com/api/v1/records/$IPV6_RECORD_ID" -H "Auth-API-Token: $HETZNER_DNS_TOKEN")
    ipv6_record_zone_id="$(echo $ipv6_record | jq -r '.record.zone_id')"
    ipv6_record_value="$(echo $ipv6_record | jq -r '.record.value')"
    ipv6_record_name="$(echo $ipv6_record | jq -r '.record.name')"
    ipv6_record_type="$(echo $ipv6_record | jq -r '.record.type')"

    echo ipv6 in record is $ipv6_record_value

    if [ "$ipv6_record_value" != "$ipv6" ]; then 
      echo records are not equal. Reconcile in progress..
      curl -s -X "PUT" "https://dns.hetzner.com/api/v1/records/$IPV6_RECORD_ID" \
        -H 'Content-Type: application/json' \
        -H "Auth-API-Token: $HETZNER_DNS_TOKEN" \
        -d "{\"value\":\"$ipv6\",\"ttl\": 60,\"type\":\"$ipv6_record_type\",\"name\":\"$ipv6_record_name\",\"zone_id\":\"$ipv6_record_zone_id\"}"
    else 
      echo records are equal.. nothing to do.
    fi
  else
    echo "IPV6 is disabled"
  fi

  sleep 120
done

