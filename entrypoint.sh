#!/bin/sh
echo ZONE_ID is $ZONE_ID
echo RECORD_ID is $RECORD_ID
echo RECORD_NAME is $RECORD_NAME
echo ECHOIP_ENDPOINT is $ECHOIP_ENDPOINT

while [ true ]
do
  ipv4=$(curl -4s $ECHOIP_ENDPOINT)
  echo ipv4 in request is $ipv4

  record_ip=$(curl -s "https://dns.hetzner.com/api/v1/records/$RECORD_ID" -H "Auth-API-Token: $HETZNER_DNS_TOKEN" | \
    jq -r '.record.value')
  echo ipv4 in record is $record_ip

  if [ "$record_ip" != "$ipv4" ]; then 
    echo records are not equal. Reconcile in progress..
    curl -s -X "PUT" "https://dns.hetzner.com/api/v1/records/$RECORD_ID" \
      -H 'Content-Type: application/json' \
      -H "Auth-API-Token: $HETZNER_DNS_TOKEN" \
      -d "{\"value\":\"$ipv4\",\"ttl\": 60,\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"zone_id\":\"$ZONE_ID\"}"
  else 
    echo records are equal.. nothing to do.
  fi
  sleep 120
done

