# frozen_string_literal: true

# a user with role student
FactoryBot.define do
  factory :student_with_new_internship, class: User do
    email { 's019517@htw-berlin.de' }
    password { 'geheim12' }
    password_confirmation { 'geheim12' }
    publicmail { true }
    mailnotif { true }
    role { :user }
    after(:create) do |user|
      student = Student.find_or_create_for(user: user)
      student.first_name = 'Anna'
      student.last_name = 'Schmidt'
      student.birthday = Date.today - 28.years
      student.save
      student.complete_internship ||= FactoryBot.create(
          :complete_internship_517,
          student: student
      )
    end
 
    factory :complete_internship_517, class: CompleteInternship do
      semester
      student
      semester_of_study { 4 }
      aep { true }
      passed { false }
      after(:create) do |ci, _evaluator|
        create_list(
            :internship_517,
            1,
            complete_internship: ci
        )
      end
    end
    factory :internship_517, class: Internship do
      working_hours { 35.0 }
      living_costs { 600.0 }
      internship_rating
      # company
      recommend { false }
      orientation
      email_public { false }
      description { "this internship is newly created for i 517" }
      salary { 8 }
      start_date { Date.today.to_date }
      end_date { Date.today.to_date + 80.days }
      tasks { "I don't know yet" }
      operational_area { 'research and testing' }
      semester
      # internship_state
      # reading_prof
      payment_state
      # registration_state - must currently be nil to be editable by student
      approved { false }
      # contract_state
      # report_state
      # certificate_state
      # certificate_signed_by_internship_officer { Date.today.to_date }
      # certificate_signed_by_prof { Date.today.to_date }
      # certificate_to_prof { Date.today.to_date }
      comment { 'something interesting' }
      supervisor_email { 'supervisor@bar.com' }
      supervisor_name { 'The Supervisor name' }
      completed { false }

      after(:build) do |i|
        c = FactoryBot.build(:company)
        i.company_address = c.company_addresses.first
      end
    end
  end
end