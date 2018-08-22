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
end
