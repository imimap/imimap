#!/usr/bin/env bash
echo "$0: starting build for IMIMAPS_ENVIRONMENT ${IMIMAPS_ENVIRONMENT}"

if [ "$IMIMAPS_ENVIRONMENT" == "docker" ]; then
  echo "lsof -i tcp:5432"
  lsof -i tcp:5432
  docker-compose build
  docker-compose run imimap "./ci-cd/travis-test-commands.sh"
else
  bundle install
  bundle exec rake db:migrate RAILS_ENV=test
  bundle exec rspec spec
fi

# for testing:
# export set IMIMAPS_ENVIRONMENT=docker
