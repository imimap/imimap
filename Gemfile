# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.2.1'

gem 'carrierwave'
gem 'country_select'
gem 'geocoder'
gem 'nested_form'

gem 'bootstrap', '~> 4.0.0'
gem 'bootstrap_form', '>= 4.0.0.alpha1'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'prawn'
gem 'prawn-table'
# see https://github.com/tzinfo/tzinfo/wiki/Resolving-TZInfo::DataSourceNotFound-Errors
gem 'tzinfo-data'

gem 'activeadmin', '~> 1.1'
gem 'cancancan', '~> 2.2'
gem 'devise', ' ~> 4.3'
gem 'formtastic', '~> 3'

# TBD Update: Observers have been removed in 4.0
# replace with ActiveRecord callbacks, maybe refactor as aspect
# as described in http://stackoverflow.com/questions/15165260/rails-observer-alternatives-for-4-0
gem 'rails-observers'

gem 'mini_magick'
# gem "rmagick", "~> 2.16"
gem 'paperclip', '~> 5.2'

gem 'chosen-rails'
# for map on startpage and overview
gem 'leaflet-rails'

gem 'kaminari'

gem 'd3-rails'
gem 'net-ldap'

# gem 'griddler'

# Gems used only for assets and not required
# in production environments by default.
# gem 'jquery-ui-rails'
gem 'coffee-rails'
gem 'font-awesome-sass-rails'
gem 'sass-rails'
gem 'uglifier', '>= 1.0.3'

# gems used for charts
gem 'active_median', '~> 0.1'
gem 'chartkick', '~> 2.2'
gem 'groupdate', '~> 3.2'

gem 'factory_bot_rails'

group :development do
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
end

# database gem
install_if -> { ENV['IMIMAPS_ENVIRONMENT'] == 'docker' } do
  gem 'pg'
end

gem 'faker'

group :development, :test do
  install_if -> { ENV['IMIMAPS_ENVIRONMENT'] != 'docker' } do
    gem 'sqlite3', '~> 1.3.7'
  end

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-rails', '~> 3'
  gem 'rspec-mocks'

  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rack-mini-profiler'

  gem 'byebug'
  gem 'database_cleaner'
  gem 'railroady'
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
end

# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

gem 'bootsnap'
gem 'listen'
