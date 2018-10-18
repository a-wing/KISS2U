#!/bin/bash

# KISS2U_AUTH_KEY=
# RAILS_ENV=
# PORT=
# POSTGRESQL_DATABASE_PASSWORD=
# SECRET_KEY_BASE=
#
#source ./config.sh
#
#echo RAILS_ENV=${RAILS_ENV}
#ruby -v
#
#if test -e tmp/pids/server.pid
#then
#  echo 'Restarting'
#  kill `cat tmp/pids/server.pid`
#else
#  echo 'Starting'
#fi
#
#bundle install --path vendor/bundle
#bundle exec rake db:migrate
#bundle exec rails server -p ${PORT} -d
systemctl --user restart kiss2u.service
