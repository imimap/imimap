#!/usr/bin/env bash
echo "$0: starting build for IMIMAPS_ENVIRONMENT ${IMIMAPS_ENVIRONMENT}"

if [ "$IMIMAPS_ENVIRONMENT" == "docker" ]; then

  echo "--------- sudo netstat -nlp | grep 5432"
  sudo netstat -nlp | grep 5432
  docker-compose up -d

  if [ $? != 0 ]; then
    echo "ERROR: docker-compose up -d FAILED"
    exit 1
  else
    echo "--------- docker exec -ti postgresql-dev netstat -nlp | grep 5432"
    docker exec -ti postgresql-dev netstat -nlp | grep 5432

    echo "done building and starting image"
    docker ps


    echo "starting tests in docker image"

    docker exec -e RAILS_ENV=test -ti imimap-dev rake db:create RAILS_ENV=test
    if [ $? != 0 ]; then echo "ERROR: db:create FAILED"; exit 1; fi
    docker exec -e RAILS_ENV=test -ti imimap-dev rake db:migrate RAILS_ENV=test
    if [ $? != 0 ]; then echo "ERROR: db:migrate FAILED"; exit 1; fi
    docker exec -e RAILS_ENV=test -ti imimap-dev rake db:migrate:status RAILS_ENV=test
    if [ $? != 0 ]; then echo "ERROR: db:migrate:status FAILED"; exit 1; fi
    docker exec -e RAILS_ENV=test -ti imimap-dev rspec spec
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
