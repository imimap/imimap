# frozen_string_literal: true

# a user with role student
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

# a user with role student without internship
FactoryBot.define do
  factory :student_user_wo_internship, class: User do
    email { 's012222@htw-berlin.de' }
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
