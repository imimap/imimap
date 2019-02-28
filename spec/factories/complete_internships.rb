# frozen_string_literal: true

FactoryBot.define do
  factory :complete_internship do
    semester { 'MyString' }
    semester_of_study { 1 }
    aep { false }
    passed { false }
  end
end
