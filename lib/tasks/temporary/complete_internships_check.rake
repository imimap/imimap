# frozen_string_literal: true

namespace :imimap do
  desc 'checks if all new associations are in place'
  task check_cis_sanity: :environment do
    internships = Internship.all
    puts "Going to check #{internships.count} internships"
    internships.each do |i|
      unless i.student_new == i.student
        puts "student association broke in internship #{i.id}"
      end
      student = i.student_new
      if student.nil?
        puts "found internship without student: #{i.id}"
        next
      end
      new_ids = student.internships_new.pluck(:id).sort
      old_ids = student.internships.pluck(:id).sort
      unless  new_ids == old_ids
        puts "internship list broke for student #{student.id}"
      end
      passed = student.internships.last.internship_state_id == 1
      ci = student.complete_internship
      puts "aep state wrong #{ci.id}" unless passed == ci.aep
      puts "aep state wrong #{ci.id}" unless passed == ci.passed
    end
    puts ' All done now!'
  end
end
