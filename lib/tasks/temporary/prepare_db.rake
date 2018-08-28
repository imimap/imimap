# frozen_string_literal: true

# inspired by https://robots.thoughtbot.com/data-migrations-in-rails

namespace :imimap do
  desc 'make kleinen@htw-berlin.de admin'
  task kleinen_admin: :environment do
    u = User.where(email: 'kleinen@htw-berlin.de').first
    u.role = :admin
    u.save!
  end
  desc 'create admin user WARNING password is contained here!'
  task create_admin: :environment do
    User.create(email: 'barne.kleinen@htw-berlin.de', password: 'geheim12',
                password_confirmation: 'geheim12', role: :admin)
  end
end
