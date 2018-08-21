# frozen_string_literal: true

# regular user with student role and associated student
FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password "foofoofoo123123"
    password_confirmation "foofoofoo123123"
    publicmail true
    mailnotif true
    after(:build) do |user|
      user.student ||= FactoryBot.build(:student, user: user)
    end
  end
end
