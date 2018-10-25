#!/bin/sh

source ./config.sh

echo "== Environment =="
echo RAILS_ENV=${RAILS_ENV}
ruby -v
echo


bin/update

