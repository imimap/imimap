# frozen_string_literal: true

I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
I18n.available_locales = %i[de en]
I18n.default_locale = :de
