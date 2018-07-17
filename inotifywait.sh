#!/bin/sh

echo $1
FILE=$1

KISS2U_AUTH_KEY="key"
URL="localhost:3000/packages"

while /usr/bin/inotifywait -e modify ${FILE};
do
  DATA=`tail -1 ${FILE}`

  curl -H "x_signture: $(echo -n "data_base64=$(echo -n ${DATA} | base64 -w 0)" | openssl dgst -sha256 -hmac ${KISS2U_AUTH_KEY} | cut -d ' ' -f 2)" ${URL} -d 'data_base64'=$(echo -n ${DATA} | base64 -w 0)

  echo
done

