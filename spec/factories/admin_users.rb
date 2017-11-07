# frozen_string_literal: true

#
FactoryGirl.define do


  factory :admin_user, class: User do
    email
    password "foofoofoo123123"
    password_confirmation "foofoofoo123123"
    publicmail true
    mailnotif true
    superuser true
    after(:build) do |user|
      user.student ||= FactoryGirl.build(:student, user: user)
    end
  end
end
