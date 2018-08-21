# frozen_string_literal: true

# a user with role prof
FactoryBot.define do
  factory :prof, class: User do
    email 'prof@example.com'
    password "geheim12"
    password_confirmation "geheim12"
    publicmail true
    mailnotif true
    role :prof
  end
end
