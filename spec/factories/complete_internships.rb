# frozen_string_literal: true

FactoryBot.define do
  factory :complete_internship do
    semester
    student
    semester_of_study { 4 }
    aep { true }
    passed { false }
  end
  factory :complete_internship_wo_student, class: CompleteInternship do
    semester
    # student
    semester_of_study { 4 }
    aep { true }
    passed { false }
  end
end
