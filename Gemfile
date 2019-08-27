# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 6.0.0'
# see https://github.com/straydogstudio/axlsx_rails
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
# gem 'axlsx_rails'
# axlsx_rails yields a deprecation warning with rails6.
# for local testing:

# gem 'axlsx_rails',
# path: '/Users/kleinen/mine/current/htw/imimap/code/axlsx_rails'
# doesn't work on travis:

gem 'axlsx_rails',
    git: 'https://github.com/imimap/axlsx_rails.git',
    tag: '0.5.2_rails6_patch'
gem 'carrierwave'
gem 'country_select'
gem 'geocoder'
gem 'nested_form'
gem 'rubyzip', '>= 1.2.1'

gem 'bootstrap', '>= 4.3.1'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap_form', '>= 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'prawn'
gem 'prawn-table'
# see https://github.com/tzinfo/tzinfo/wiki/Resolving-TZInfo::DataSourceNotFound-Errors
gem 'tzinfo-data'

gem 'activeadmin', '~> 2.2'
gem 'cancancan', '~> 2.2'
gem 'devise', ' ~> 4.3'
gem 'formtastic', '~> 3'

gem 'mini_magick'
# gem "rmagick", "~> 2.16"
gem 'paperclip', '~> 5.2'

# is this needed directly or just used by activeadmin?
# see https://github.com/kaminari/kaminari
# calls like User.page would occur
gem 'kaminari'

gem 'd3-rails'
gem 'net-ldap'

# gem 'griddler'

# Gems used only for assets and not required
# in production environments by default.
# gem 'jquery-ui-rails'
gem 'coffee-rails'
gem 'font-awesome-sass-rails'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'uglifier', '>= 1.0.3'

gem 'factory_bot_rails'

group :development do
  gem 'brakeman'
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
    gem 'sqlite3', '~> 1.4'
  end

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 3'

  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  # gem 'rack-mini-profiler', require: false

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
