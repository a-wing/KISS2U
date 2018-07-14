#!/bin/bash
export KISS2U_AUTH_KEY=
export RAILS_ENV=
export PORT=
#export POSTGRESQL_DATABASE_PASSWORD=
export SECRET_KEY_BASE=


echo $RAILS_ENV
pwd
ruby -v

cd KISS2U/
pwd

if test -e tmp/pids/server.pid
then
  echo 'Restarting'
  kill `cat tmp/pids/server.pid`
else
  echo 'Starting'
fi

bundle install --path vendor/bundle
bundle exec rake db:migrate
bundle exec rails server -p ${PORT} -d

