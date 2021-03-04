#!/usr/bin/env bash
echo "$0: starting build for IMIMAPS_ENVIRONMENT ${IMIMAPS_ENVIRONMENT}"

  echo "--------- ./ci-cd/deploy00-echo-settings.sh"
  . ./ci-cd/deploy00-echo-settings.sh

  echo "--------- sudo netstat -nlp | grep 5432"
  sudo netstat -nlp | grep 5432

  echo "docker hub limits before build"
  export DOCKER_API_TOKEN=$(curl "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq -r .token)
  curl --head -H "Authorization: Bearer $DOCKER_API_TOKEN" https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest

  docker-compose up -d

  echo "docker hub limits after build"
  curl --head -H "Authorization: Bearer $DOCKER_API_TOKEN" https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest

  if [ $? != 0 ]; then
    echo "ERROR: docker-compose up -d FAILED"
    exit 1
  else
    echo "--------- docker exec -ti postgresql-dev netstat -nlp | grep 5432"
    docker exec -ti postgresql-dev netstat -nlp | grep 5432

    echo "done building and starting image"
    docker ps


    echo "starting tests in docker image"
    docker exec -ti imimap-dev ./ci-cd/wait-for-db-connection.sh
    docker exec -e RAILS_ENV=test -ti imimap-dev rake db:create RAILS_ENV=test
    docker exec -e RAILS_ENV=test -ti imimap-dev rake db:migrate RAILS_ENV=test
    if [ $? != 0 ]; then exit 1; fi
    docker exec -e RAILS_ENV=test -ti imimap-dev rake db:migrate:status RAILS_ENV=test
    docker exec -e RAILS_ENV=test -ti imimap-dev rspec spec
    if [ $? != 0 ]; then exit 1; fi
    docker exec -e RAILS_ENV=test -ti imimap-dev rake assets:precompile
    if [ $? != 0 ]; then exit 1; fi
    docker exec -e RAILS_ENV=test -ti imimap-dev rails db:seed
    if [ $? != 0 ]; then exit 1; fi
    # docker exec -e RAILS_ENV=test -ti imimap-dev rubocop
    # if [ $? != 0 ]; then exit 1; fi
    # docker exec -e RAILS_ENV=test -ti imimap-dev rails factory_bot:lint
  fi
