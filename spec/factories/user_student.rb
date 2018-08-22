# frozen_string_literal: true

# a user with role prof
FactoryBot.define do
  factory :student_user, class: User do
    email { 's012345@htw-berlin.de' }
    password { 'geheim1234' }
    password_confirmation { 'geheim1234' }
    publicmail { true }
    mailnotif { true }
    role { :user }
    after(:build) do |user|
      user.student ||= FactoryBot.build(:student, user: user)
    end
  end
end
