# frozen_string_literal: true

FactoryBot.define do
  factory :complete_internship do
    semester { 'WS 2019/20' }
    semester_of_study { 4 }
    aep { true }
    passed { false }
  end
end
