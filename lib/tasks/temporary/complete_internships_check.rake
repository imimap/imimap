# frozen_string_literal: true

def check_internships(student)
  new_ids = student.internships_new.pluck(:id).sort
  old_ids = student.internships.pluck(:id).sort
  return if new_ids == old_ids

  puts "internship list broke for student #{student.id}"
end

def check_passed_aep(student)
  passed = student.last_internship.passed?
  ci = student.complete_internship
  puts "aep state wrong #{ci.id}" unless passed == ci.aep
  puts "passed state wrong #{ci.id}" unless passed == ci.passed
end

def check_semester(student)
  last_internship = student.last_internship
  ci = student.complete_internship
  puts 'semester wrong' unless last_internship.semester == ci.semester
end

namespace :imimap do
  desc 'checks if all new associations are in place'
  task check_cis_sanity: :environment do
    internships = Internship.all
    puts "Going to check #{internships.count} internships"
    internships.each do |i|
      print '.'
      unless i.student_new == i.student
        puts "student association broke in internship #{i.id}"
      end
      student = i.student_new
      if student.nil?
        puts "found internship without student: #{i.id}"
        next
      end
      check_passed_aep(student)
      check_internships(student)
      check_semester(student)
    end
    puts ' All done now!'
  end
end
