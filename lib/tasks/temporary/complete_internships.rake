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
          aep: ,
          passed: ,
          semester: ,
          i

          internships.each do | i |
          end
        )
        ci.save!

      end
      puts
    end
    puts ' All done now!'
  end

  desc 'associate Internships with company_address'
  task update_internships: :environment do
    internships = Internship.all
    puts "Going to update #{internships.count} Internships"

    ActiveRecord::Base.transaction do
      internships.each do |i|
        address = i.company.company_addresses.first
        i.company_address = address
        i.save!
        puts '.'
      end
      puts
    end
    puts ' All done now!'
  end
end

#    remove_column :companies, :city, :string
#    remove_column :companies, :country, :string
#    remove_column :companies, :street, :string
#    remove_column :companies, :zip, :string
#    remove_column :companies, :phone, :string
#    remove_column :companies, :fax
