#!/bin/sh

ELASTICSEARCH_ENDPOINT="elasticsearch-master:9200"
API_RESPONSE=$(curl $ELASTICSEARCH_ENDPOINT/_aliases 2> /dev/null | jq 'keys' | jq -r .[] | grep logstash)
API_RESPONSE_INDEX_COUNT=$(echo "$API_RESPONSE" | wc -l)
INDEX_COUNT_RETAIN=7

if [ $API_RESPONSE_INDEX_COUNT -gt $INDEX_COUNT_RETAIN ]; then
  echo -e "Indices:\n$API_RESPONSE"
  
  index_to_delete=$(($API_RESPONSE_INDEX_COUNT - $INDEX_COUNT_RETAIN))

  for index in $(echo "$API_RESPONSE" | head -n $index_to_delete); do
    echo "Deleting $index..."
    curl -X DELETE "$ELASTICSEARCH_ENDPOINT/$index?pretty"
  done
else
  echo "No indices to delete... still $API_RESPONSE_INDEX_COUNT"
fi