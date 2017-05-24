#!/usr/bin/env bash
echo "starting travis-build.sh for IMIMAPS_ENVIRONMENT ${IMIMAPS_ENVIRONMENT}"
echo "SKIPPING"
#if [ "$IMIMAPS_ENVIRONMENT" == "docker" ]; then
#  ./docker-tool test start
#else
#  bundle install
#  bundle exec rake db:migrate RAILS_ENV=test
#  bundle exec rspec spec
#fi
