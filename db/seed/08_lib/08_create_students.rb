# frozen_string_literal: true

# if users are created, the password is geheim12
require_relative './08_lib'

Rails.configuration.seed_data.each do |sd|
  puts "creating ##{sd.enrolment_number_range}, " \
       "internships: #{sd.with_internships}," \
       " user: #{sd.with_user}, student: #{sd.with_student}"
  sd.enrolment_number_range.each do |er|
    create_for_seed_data(enrolment_number: er,
                         seed_data: sd)
  end
end
