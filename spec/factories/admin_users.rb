# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user, class: User do
    email
    password { 'foofoofoo123123' }
    password_confirmation { 'foofoofoo123123' }
    publicmail { true }
    mailnotif { true }
    role { :admin }
  end
  factory :admin, class: User do
    sequence :email do |n|
      "admin#{n}@htw-berlin.de"
    end
    password { 'geheim12' }
    password_confirmation { 'geheim12' }
    publicmail { true }
    mailnotif { true }
    role { :admin }
  end
end
