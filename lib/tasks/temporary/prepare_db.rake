# frozen_string_literal: true

# inspired by https://robots.thoughtbot.com/data-migrations-in-rails

namespace :imimap do
  desc 'create initial admin'
  task kleinen: :environment do
    u = User.where(email: 'kleinen@htw-berlin.de').first
    u.role = :admin
    u.save!
  end
end
