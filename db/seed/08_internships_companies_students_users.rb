# frozen_string_literal: true

require_relative './lib/08_lib.rb'

Student.destroy_all
Internship.destroy_all
Company.destroy_all
CompanyAddress.destroy_all

include InternshipSeeds

for er in 10_001..10_020
  create_student(enrolment_number: er, with_internship: true, with_user: false)
end

for er in 20_001..20_020
  create_student(enrolment_number: er, with_internship: false, with_user: true)
end

for er in 30_001..30_020
  create_student(enrolment_number: er, with_internship: false, with_user: false)
end
