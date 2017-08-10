#!/usr/bin/env bash
echo "$0: starting build for IMIMAPS_ENVIRONMENT ${IMIMAPS_ENVIRONMENT}"

if [ "$IMIMAPS_ENVIRONMENT" == "docker" ]; then
  echo "lsof -i tcp:5432"
  lsof -i tcp:5432
  docker-compose up -d
  echo "done building and starting image"
  #echo "starting tests in docker image"
  #docker-compose run imimap "./ci-cd/travis-test-commands.sh"

  docker exec -e RAILS_ENV=test -ti imimaps-dev rake db:create RAILS_ENV=test
  docker exec -e RAILS_ENV=test -ti imimaps-dev rake db:migrate RAILS_ENV=test
  docker exec -e RAILS_ENV=test -ti imimaps-dev rake db:migrate:status RAILS_ENV=test
  docker exec -e RAILS_ENV=test -ti imimaps-dev rspec spec


else
  bundle install
  bundle exec rake db:migrate RAILS_ENV=test
  bundle exec rspec spec
fi

# for testing:
# export set IMIMAPS_ENVIRONMENT=docker
