# frozen_string_literal: true

# inspired by https://robots.thoughtbot.com/data-migrations-in-rails
# roll back:
# Internship.all.each{|i| i.complete_internship = nil; i.save!}
# CompleteInternship.destroy_all
def complete_internship_for(student:, internship:)
  passed_and_aep = internship.passed?
  CompleteInternship.new(
    student: student,
    aep: passed_and_aep,
    passed: passed_and_aep,
    semester: internship.semester
  )
end
namespace :imimap do
  desc 'create complete_internship between student and internship'
  task create_cis: :environment do
    students = Student.all
    puts "Going to create complete_internships for #{students.count} students"
    ActiveRecord::Base.transaction do
      students.each do |student|
        internships = student.internships
        next if internships.empty?

        unless student.complete_internship.nil?
          puts "complete internship exists for student #{student.id}, skipping"
          next
        end
        last_internship = student.last_internship
        ci = complete_internship_for(student: student,
                                     internship: last_internship)
        ci.save!
        internships.each do |tp|
          # irgendwie beziehung der tps zu ci herstellen
          tp.complete_internship = ci
          tp.save!
        end
      end
    end
    puts ' All done now!'
  end
end
