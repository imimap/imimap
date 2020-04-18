# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.1'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# IMI-Map Specific - start
Rails.application.config.assets.precompile += %w[leaflet.css]
Rails.application.config.assets.precompile += %w[leaflet.js]
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are
# already added.

Rails.application.config.assets.precompile += %w[internships.js]
Rails.application.config.assets.precompile += %w[internships.css]

Rails.application.config.assets.precompile += %w[startpage.css]

Rails.application.config.assets.precompile += %w[bootstrap-custom.css]
Rails.application.config.assets.precompile += %w[custom.css]
Rails.application.config.assets.precompile += %w[favorite.css]
Rails.application.config.assets.precompile += %w[financing.css]
Rails.application.config.assets.precompile += %w[internships.css]
Rails.application.config.assets.precompile += %w[search.css]
Rails.application.config.assets.precompile += %w[stylesheet_desktop.css]
Rails.application.config.assets.precompile += %w[stylesheet_phone.css]
Rails.application.config.assets.precompile += %w[stylesheet_tablet.css]
Rails.application.config.assets.precompile += %w[users.css]
Rails.application.config.assets.precompile += %w[viz.css]
Rails.application.config.assets.precompile += %w[report_overview.js]
Rails.application.config.assets.precompile += %w[report_overview.css]

# puts '+++Rails.application.config.assets.precompile'
# puts Rails.application.config.assets.precompile.inspect
# IMI-Map Specific - end
