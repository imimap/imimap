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

  factory :user_for_s05, class: User do
    email { 's051234@htw-berlin.de' }
    password { 'foofoofoo123123' }
    password_confirmation { 'foofoofoo123123' }
    publicmail { true }
    mailnotif { true }
    after(:build) do |user|
      user.student ||= FactoryBot.build(:student_s051234,
                                        email: user.email,
                                        user: user)
    end
  end

  factory :user_without_student, class: User do
    email { 'notastudent@htw-berlin.de' }
    password { 'foofoofoo123123' }
    password_confirmation { 'foofoofoo123123' }
    publicmail { true }
    mailnotif { true }
  end

  factory :examination_office, class: User do
    email { 'pv@htw-berlin.de' }
    password { 'foofoofoo123123' }
    password_confirmation { 'foofoofoo123123' }
    publicmail { true }
    mailnotif { true }
    role { :examination_office }
  end
end
