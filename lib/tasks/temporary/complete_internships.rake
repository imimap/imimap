# frozen_string_literal: true

# inspired by https://robots.thoughtbot.com/data-migrations-in-rails

namespace :imimap do
  desc 'create an address object for each company'
  task create_cis: :environment do
    students = Student.all
    puts "Going to update internships for #{students.count} students"

    ActiveRecord::Base.transaction do
      students.each do |s|
        i = s.internships.last
        ci = CompleteInternship.new(
          student: s,
          aep: i.state == passed, # wenn der status des praktikums 'passed' ist, ist aep true, sonst nicht
          passed: i.state == passed, # das selbe gilt für passed
          # überlegungen, da mir im moment nicht klar ist, wie ich an den state der internship komme:
          # alternativ könnte man überlegen hier über certificate_signed_by_internship_officer ran zu gehen: wenn unterschrieben ist, dann war auf jeden fall ein AEP da
          # aep: i.certificate_signed_by_internship_officer ? true : false,
          # für passed gilt im moment das selbe: wenn es unterschrieben ist, dann müsste es auch passed sein
          # passed: i.certificate_signed_by_internship_officer ? true : false,
          # BEIDES FUNKTIONIERT ABER NUR WENN NICHT UNTERSCHRIEBEN AUCH WIRKLICH nil IST UND NICHT NUR blank
          # sonst:
          # aep: not i.certificate_signed_by_internship_officer.blank?,
          # passed: not i.certificate_signed_by_internship_officer.blank?,
          semester: i.semester # semester im format SS 19, nicht fachsemester
          # das fachsemester wird also erstmal frei gelassen?
        )
        ci.save!

        # für jedes teilpraktikum:
        s.internships.each do |tp|
          # irgendwie beziehung der tps zu ci herstellen
        end

      end
      puts '.'
    end
    puts ' All done now!'
  end
end
