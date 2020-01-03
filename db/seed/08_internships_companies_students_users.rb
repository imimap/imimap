# frozen_string_literal: true

require_relative './08_lib/08_lib.rb'

Student.destroy_all
Internship.destroy_all
CompleteInternship.destroy_all
Company.destroy_all
CompanyAddress.destroy_all

# if users are created, the password is geheim12

Rails.configuration.seed_data.each do |sd|
  puts "creating ##{sd.enrolment_number_range}, internships: #{sd.with_internships}," \
       " user: #{sd.with_user}, student: #{sd.with_student}"
  sd.enrolment_number_range.each do |er|
    create_for_seed_data(enrolment_number: er,
                         seed_data: sd)
  end
end
