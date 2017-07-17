source 'https://rubygems.org'

gem 'rails', '~> 4.2.8'
gem 'bootstrap-sass', '2.1'
gem 'carrierwave'
gem 'geocoder'
gem 'gmaps4rails'
gem 'nested_form'
gem "country_select"

# see https://github.com/tzinfo/tzinfo/wiki/Resolving-TZInfo::DataSourceNotFound-Errors
gem 'tzinfo-data'

gem 'activeadmin', "~> 1.0"
#gem 'formtastic', "~> 3"
gem 'devise', ' ~> 4.3'

# TBD Update: replace by new mechanism
#  `attr_accessible` is extracted out of Rails into a gem. Please use new recommended protection model for params(strong_parameters) or add `protected_attributes` to your Gemfile to use old one.
# "Rails 4.0 has removed attr_accessible and attr_protected feature in favor of Strong Parameters. You can use the Protected Attributes gem for a smooth upgrade path."
# "If you are not using Protected Attributes, you can remove any options related to this gem such as whitelist_attributes or mass_assignment_sanitizer options."
gem 'protected_attributes'

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

gem 'jquery-rails', '3.1.4'


# Gems used only for assets and not required
# in production environments by default.
gem 'jquery-ui-rails'
gem 'sass-rails',   '~> 4.0'
gem 'coffee-rails', '~> 4.0'
gem 'font-awesome-sass-rails'
gem 'uglifier', '>= 1.0.3'



gem 'factory_girl_rails'

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

# database gem
install_if -> { ENV['IMIMAPS_ENVIRONMENT'] == "docker" } do
  gem "pg"
end

group :development, :test do
  install_if -> { ENV['IMIMAPS_ENVIRONMENT'] != "docker" } do
    gem 'sqlite3', '~> 1.3.7'
  end
end

group :development, :test do

  gem 'rspec-rails', '~> 3.5'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'rack-mini-profiler'

  gem 'railroady'
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
