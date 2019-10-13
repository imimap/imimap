# frozen_string_literal: true

require_relative './08_lib/08_lib.rb'

Student.destroy_all
Internship.destroy_all
CompleteInternship.destroy_all
Company.destroy_all
CompanyAddress.destroy_all

# if users are created, the password is geheim12

range = 11_001..11_020
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 1,
                      with_user: false)
end
range = 12_001..12_020
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 0,
                      with_user: true)
end
range = 13_001..13_020
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 0,
                      with_user: false)
end
range = 40_001..40_02
puts "creating ##{range}"
range.each do |er|
  create_student_with(enrolment_number: er,
                      with_internships: 2,
                      with_user: true)
end

puts 's011 - internships: 1, user: false'
puts 's012 - internships: 0, user: true'
puts 's013 - internships: 0, user: false'
puts 's014 - internships: 2, user: true'
