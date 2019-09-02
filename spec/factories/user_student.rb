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

  factory :student_user_with_fresh_complete_internship, class: User do
    email { 's012005@htw-berlin.de' }
    password { 'geheim12' }
    password_confirmation { 'geheim12' }
    publicmail { false }
    mailnotif { true }
    role { :user }
    after(:build) do |user|
      student = user.student ||= FactoryBot.build(:student, user: user)
      student.complete_internship ||= FactoryBot.build(
        :complete_internship_wo_student,
        student: student
      )
    end
  end
end
