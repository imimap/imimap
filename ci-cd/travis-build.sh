#!/usr/bin/env bash
if [ "$DATABASE" == "postgres" ]; then
  ./docker-tool test start
else
  bundle install
  bundle exec rake db:migrate RAILS_ENV=test
  bundle exec rspec spec
fi
