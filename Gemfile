source 'https://rubygems.org'

gem 'rails', '~> 3.2.22'
gem 'bootstrap-sass', '2.1'
gem 'carrierwave'
gem 'geocoder'
gem 'gmaps4rails'
gem 'nested_form'
gem "country-select"

gem 'activeadmin', "~> 0.6"

gem "rmagick", "~> 2.13.1"
gem "paperclip", "~> 2.7"
gem "date-input-rails"

gem 'chosen-rails'

gem 'kaminari'

gem "d3-rails"
gem "net-ldap"

#gem 'griddler'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails', '2.2.1'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'jquery-ui-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'font-awesome-sass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  #gem "therubyracer"
  #gem "less-rails"
  #gem 'twitter-bootstrap-rails'
end

gem 'factory_girl_rails'

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
  gem 'rack-mini-profiler'

  gem 'railroady'
  gem 'database_cleaner'
  gem "simplecov", require: false
end



# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'


# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
