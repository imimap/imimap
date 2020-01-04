# frozen_string_literal: true

FactoryBot.define do
  factory :complete_internship do
    semester
    student
    semester_of_study { 4 }
    aep { true }
    passed { false }
  end
  factory :complete_internship_with_internship, class: CompleteInternship do
    semester
    student
    semester_of_study { 4 }
    aep { true }
    passed { false }
    after(:create) do |ci, _evaluator|
      create_list(
        :internship,
        1,
        complete_internship: ci
      )
    end
  end
  factory :complete_internship_no_aep, class: CompleteInternship do
    semester
    student
    semester_of_study { 7 }
    aep { false }
    passed { false }
  end

  factory :complete_internship_w_fresh_internship, class: CompleteInternship do
    semester
    student
    semester_of_study { 4 }
    aep { true }
    passed { false }

    after(:create) do |ci, _evaluator|
      create_list(
        :internship_without_company_address,
        1,
        complete_internship: ci
      )
    end
  end
end
