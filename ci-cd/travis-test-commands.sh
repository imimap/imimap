#!/usr/bin/env bash
echo $0
echo "./ci-cd/travis-test-commands.sh"
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rspec spec
