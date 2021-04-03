# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 6.1.3'

gem 'carrierwave'
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'country_select'
gem 'geocoder'

gem 'bootstrap', '>= 4.3.1'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap_form', '>= 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'prawn'
gem 'prawn-table'
# see https://github.com/tzinfo/tzinfo/wiki/Resolving-TZInfo::DataSourceNotFound-Errors
gem 'tzinfo-data'

gem 'activeadmin', '~> 2.9'
gem 'cancancan', '~> 3.0'
gem 'devise', '>= 4.7.1'
gem 'formtastic', '~> 3'
# database gem
gem 'pg'

gem 'net-ldap',
    git: 'https://github.com/imimap/ruby-net-ldap',
    tag: 'v0.16.2.deprecation.removed'

# gem 'griddler'

# Gems used only for assets and not required
# in production environments by default.
# gem 'jquery-ui-rails'
gem 'coffee-rails'
gem 'font-awesome-sass-rails'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'uglifier', '>= 1.0.3'

gem 'factory_bot_rails', '>= 5.1'

group :development do
  gem 'brakeman'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-mocks'
  gem 'rspec-rails'

  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  # gem 'rack-mini-profiler', require: false

  gem 'byebug'
  gem 'database_cleaner'
  gem 'pdf-reader' # for checking generated pdf in tests
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
end

# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3'

# faker needs to be in general section to enable seeding on staging
gem 'faker'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

gem 'bootsnap'
gem 'listen'
