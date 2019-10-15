# frozen_string_literal: true

require_relative './08_lib/08_lib.rb'

Student.destroy_all
Internship.destroy_all
CompleteInternship.destroy_all
Company.destroy_all
CompanyAddress.destroy_all

# if users are created, the password is geheim12

range = 110_001..110_020
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 1,
                      with_user: false)
end
range = 120_001..120_020
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 0,
                      with_user: true)
end
range = 130_001..130_020
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 0,
                      with_user: false)
end
range = 140_001..140_020
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 2,
                      with_user: true)
end
range = 150_001..150_020
puts "creating ##{range} without test status for toggles"
# see TEST_EMAIL_REGEXP
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: (er % 3),
                      with_user: true)
end
range = 150_101..150_120
puts "creating ##{range} - only user objects"
# see TEST_EMAIL_REGEXP
range.each do |er|
  create_only_user(enrolment_number: er)
end

puts 's011 - internships: 1, user: false'
puts 's012 - internships: 0, user: true'
puts 's013 - internships: 0, user: false'
puts 's014 - internships: 2, user: true'
puts 's015 - internships: er mod 3, user: true'
