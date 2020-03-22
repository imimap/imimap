# frozen_string_literal: true

FactoryBot.define do
  factory :postponement do
    complete_internship { nil }
    semester { nil }
    semester_of_study { 1 }
    placed_at { '2020-03-22 12:03:28' }
    approved_at { '2020-03-22 12:03:28' }
    approved_by { nil }
  end
end
