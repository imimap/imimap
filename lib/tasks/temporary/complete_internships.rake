# frozen_string_literal: true

# inspired by https://robots.thoughtbot.com/data-migrations-in-rails
# roll back:
# Internship.all.each{|i| i.complete_internship = nil; i.save!}
# CompleteInternship.destroy_all
def complete_internship_for(student:, internship:)
  passed_and_aep = internship.internship_state_id == 1 # passed
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
      students.each do |s|
        internships = s.internships
        next if internships.empty?

        unless s.complete_internship.nil?
          puts "complete internship exists for student #{s.id}, skipping"
          next
        end
        max_id = internships.pluck(:id).max
        last_internship = Internship.find(max_id)
        ci = complete_internship_for(student: s, internship: last_internship)
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
