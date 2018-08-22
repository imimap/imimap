# frozen_string_literal: true

# a user with role prof
FactoryBot.define do
  factory :prof, class: User do
    email { 'prof@example.com' }
    password { 'geheim123' }
    password_confirmation { 'geheim123' }
    publicmail { false }
    mailnotif { true }
    role { :prof }
  end
end
