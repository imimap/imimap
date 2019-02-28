# frozen_string_literal: true

# regular user with student role and associated student
FactoryBot.define do
  sequence :email do |n|
    format('s02%03d8@htw-berlin.de', n)
  end

  factory :user do
    email
    password { 'foofoofoo123123' }
    password_confirmation { 'foofoofoo123123' }
    publicmail { true }
    mailnotif { true }
    after(:build) do |user|
      user.student ||= FactoryBot.build(:student, user: user)
    end
  end

  factory :user_without_student, class: User do
    email
    password { 'foofoofoo123123' }
    password_confirmation { 'foofoofoo123123' }
    publicmail { true }
    mailnotif { true }
  end

  factory :examination_office, class: User do
    email
    password { 'foofoofoo123123' }
    password_confirmation { 'foofoofoo123123' }
    publicmail { true }
    mailnotif { true }
    role { :examination_office }
  end
end
