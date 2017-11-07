# frozen_string_literal: true

#
FactoryBot.define do


  factory :admin_user, class: User do
    email
    password "foofoofoo123123"
    password_confirmation "foofoofoo123123"
    publicmail true
    mailnotif true
    superuser true
    after(:build) do |user|
      user.student ||= FactoryBot.build(:student, user: user)
    end
  end
end
