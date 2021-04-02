# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImiMaps
  # The Rails Application.
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # puts "config.load_defaults 5.0"
    config.load_defaults 5.0
    # this overrides things set in new_framework_defaults.rb - thus this ugly hack:
    Rails.application.config.active_record.belongs_to_required_by_default = false
    config.use_transactional_tests = true
    # TBD: needs to be cleaned up

    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # IMI-Map settings
    config.autoload_paths += %W[#{config.root}/lib]
    config.autoload_paths += %W[#{config.root}/lib/model]
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]
    custom_locales = Rails.root.join('config', 'locales', '**/*.{rb,yml}').to_s
    config.i18n.load_path += Dir[custom_locales]
    config.i18n.default_locale = :de
    config.i18n.available_locales = %i[de en]
    # required by heroku.
    # http://guides.rubyonrails.org/v3.2.8/asset_pipeline.html
    config.assets.initialize_on_precompile = false

    # TBD Update: distribute this over the environments with appropriate
    # settings from ENV variable
    config.action_mailer.default_url_options = { host: 'localhost' }
    # IMI-Map settings end
  end
end
