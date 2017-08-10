#!/usr/bin/env bash
bundle exec rake db:create RAILS_ENV=test
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rspec spec
