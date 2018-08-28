# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    first_name { 'Tuennes' }
    last_name { 'Schael' }
    enrolment_number { '123456' }
    birthday { Date.today - 28.years }
    birthplace { 'Cologne' }
    email { 'foo@bar.com' }
    # user
    after(:build) do |student|
      student.user ||= FactoryBot.build(:user, student: student)
    end
  end
  factory :student2, class: Student do
    first_name { 'Ada' }
    last_name { 'Lovelace' }
    enrolment_number { '78934' }
    birthday { Date.today - 28.years }
    birthplace { 'Washington' }
    email { 'ada@test.org' }
    # user
    after(:build) do |student|
      student.user ||= FactoryBot.build(:user, student: student)
    end
  end
end
