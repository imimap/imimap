# frozen_string_literal: true

require_relative './lib/08_lib.rb'

Student.destroy_all
Internship.destroy_all
Company.destroy_all
CompanyAddress.destroy_all

(20_001..20_020).each do |er|
  create_student(enrolment_number: er, with_internship: false, with_user: true)
end

(30_001..30_020).each do |er|
  create_student(enrolment_number: er, with_internship: false, with_user: false)
end

(10_001..10_020).each do |er|
  create_student(enrolment_number: er, with_internship: true, with_user: false)
end
