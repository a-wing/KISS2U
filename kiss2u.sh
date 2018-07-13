#!/bin/sh

echo $1
#DATA="[2018-07-07 18:27:06] vim-rust-git 20180707.065817 successful after 15s"
#DATA="[2018-07-07 18:07:24] openblas-lapack-git 1.281.4dd70d98d7481e8a355fd4f43e6630e29a31927a failed after 5s"
KISS2U_AUTH_KEY="key"
URL="localhost:3000/packages"

while ((`cat $1|wc -l` >= 1))
do
  DATA=`head -1 $1`
  sed -i '1d' $1

  curl -H "x_signture: $(echo -n "data_base64=$(echo -n ${DATA} | base64 -w 0)" | openssl dgst -sha256 -hmac ${KISS2U_AUTH_KEY} | cut -d ' ' -f 2)" ${URL} -d 'data_base64'=$(echo -n ${DATA} | base64 -w 0)

  echo
done
