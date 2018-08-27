# frozen_string_literal: true

require_relative './lib/08_lib.rb'

Student.destroy_all
Internship.destroy_all
Company.destroy_all
CompanyAddress.destroy_all

include InternshipSeeds

for er in 10001..10020
  create_student(enrolment_number: er, with_internship: true, with_user: false)
end

for er in 20001..20020
  create_student(enrolment_number: er, with_internship: false, with_user: true)
end

for er in 30001..30020
  create_student(enrolment_number: er, with_internship: false, with_user: false)
end
