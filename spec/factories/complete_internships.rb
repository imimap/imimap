# frozen_string_literal: true

FactoryBot.define do
  factory :complete_internship do
    semester
    semester_of_study { 4 }
    aep { false }
    passed { false }
  end
end
