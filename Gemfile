source 'https://rubygems.org'

gem 'rails', '~> 5.0.6'
gem 'carrierwave'
gem 'geocoder'
gem 'nested_form'
gem "country_select"
gem 'bootstrap-sass', '~> 3.3.5'

# see https://github.com/tzinfo/tzinfo/wiki/Resolving-TZInfo::DataSourceNotFound-Errors
gem 'tzinfo-data'

gem 'activeadmin', "~> 1.0"
gem 'formtastic', "~> 3"
gem 'devise', ' ~> 4.3'

# TBD Update: Observers have been removed in 4.0
# replace with ActiveRecord callbacks, maybe refactor as aspect
# as described in http://stackoverflow.com/questions/15165260/rails-observer-alternatives-for-4-0
gem 'rails-observers'


gem "rmagick", "~> 2.13.1"
gem "paperclip", "~> 2.7"

gem 'chosen-rails'

gem 'kaminari'

gem "d3-rails"
gem "net-ldap"

#gem 'griddler'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails'


# Gems used only for assets and not required
# in production environments by default.
gem 'jquery-ui-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'font-awesome-sass-rails'
gem 'uglifier', '>= 1.0.3'

#gems used for charts
gem 'chartkick', '~> 1.2.4'
gem 'groupdate', '~> 2.1.1'
gem 'active_median', '~> 0.1.0'

gem 'factory_bot_rails'

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rubocop', '~> 0.51.0'
end

# database gem
install_if -> { ENV['IMIMAPS_ENVIRONMENT'] == "docker" } do
  gem "pg"
end

group :development, :test do
  install_if -> { ENV['IMIMAPS_ENVIRONMENT'] != "docker" } do
    gem 'sqlite3', '~> 1.3.7'
  end

  gem 'faker'
  gem 'rspec-rails', '~> 3.5'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'rack-mini-profiler'

  gem 'railroady'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem "simplecov", require: false
  gem 'byebug'
end

# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3'


# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
