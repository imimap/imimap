# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    first_name { 'Tuennes' }
    last_name { 'Schael' }
    enrolment_number { '123456' }
    birthday { Date.today - 28.years }
    birthplace { 'Cologne' }
    email { 's0123456@htw-berlin.de' }
    private_email { 'foo@bar.com' }
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
    email { 's0123457@htw-berlin.de' }
    private_email { 'ada@test.org' }
    # user
    after(:build) do |student|
      student.user ||= FactoryBot.build(:user, student: student)
    end
  end

  factory :student_s051234, class: Student do
    first_name { 'First' }
    last_name { 'Last' }
    enrolment_number { '512343' }
    birthday { Date.today - 28.years }
    birthplace { 'Somewhere' }
    email { 's0512343@htw-berlin.de' }
    private_email { 'rolf@test.org' }
    # user
    after(:build) do |student|
      student.user ||= FactoryBot.build(:user, student: student)
    end
  end
end
