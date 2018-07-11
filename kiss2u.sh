#!/bin/sh
#DATA="[2018-07-07 18:27:06] vim-rust-git 20180707.065817 successful after 15s"
DATA="[2018-07-07 18:07:24] openblas-lapack-git 1.281.4dd70d98d7481e8a355fd4f43e6630e29a31927a failed after 5s"
KISS2U_AUTH_KEY="key"

curl -H "x_signture: $(echo -n "data_base64=$(echo -n ${DATA} | base64 -w 0)" | openssl dgst -sha256 -hmac ${KISS2U_AUTH_KEY} | cut -d ' ' -f 2)" localhost:3000/packages -d 'data_base64'=$(echo -n ${DATA} | base64 -w 0)
