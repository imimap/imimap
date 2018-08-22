require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImiMaps
  class Application < Rails::Application
    #LDAP SETTINGS
    config.x.ldapServerAddr = "141.45.146.101"
    config.x.ldapPort = 389

    #Prüfungs Verwaltung email
    config.x.pv_Email = "someemail@htw-berlin.de"

    # IMI-Map settings
    config.active_record.observers = :user_comment_observer, :answer_observer, :internship_observer, :user_observer
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*.{rb,yml}').to_s]
    config.i18n.default_locale = :de
    config.i18n.available_locales = [:de,:en]
    # required by heroku. http://guides.rubyonrails.org/v3.2.8/asset_pipeline.html
    config.assets.initialize_on_precompile = false

    # TBD Update: distribute this over the environments with appropriate settings from ENV variable
    config.action_mailer.default_url_options = { :host => "localhost" }
    # IMI-Map settings end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
