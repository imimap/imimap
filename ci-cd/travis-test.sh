#!/usr/bin/env bash
echo "$0: starting build for IMIMAPS_ENVIRONMENT ${IMIMAPS_ENVIRONMENT}"

if [ "$IMIMAPS_ENVIRONMENT" == "docker" ]; then

  echo "--------- netstat -nlp | grep 5432"
  netstat -nlp | grep 5432
  docker-compose up -d

  if [ $? != 0 ]; then
    echo "ERROR: docker-compose up -d FAILED"
    exit 1
  else
    echo "--------- docker exec -ti postgresql-dev netstat -nlp | grep 5432"
    docker exec -ti postgresql-dev netstat -nlp | grep 5432

    echo "done building and starting image"
    echo "starting tests in docker image"


    docker exec -e RAILS_ENV=test -ti imimaps-dev rake db:create RAILS_ENV=test
    docker exec -e RAILS_ENV=test -ti imimaps-dev rake db:migrate RAILS_ENV=test
    docker exec -e RAILS_ENV=test -ti imimaps-dev rake db:migrate:status RAILS_ENV=test
    docker exec -e RAILS_ENV=test -ti imimaps-dev rspec spec
  fi

else
  gem install bundler
  bundle --version
  bundle install
  bundle exec rake db:migrate RAILS_ENV=test
  bundle exec rspec spec
fi

# for testing:
# export set IMIMAPS_ENVIRONMENT=docker
