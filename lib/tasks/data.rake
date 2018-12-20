# frozen_string_literal: true

namespace :imimap do
  desc 'map old database data to new format'
  task map_old_data: :environment do
    require 'database_parser'

    parser = DatabaseParser.new(
      student_file: '/home/deployer/data/students_view.csv',
      internships_file: '/home/deployer/data/internships_view.csv',
      companies_file: '/home/deployer/data/companies_view.csv'
    )
    parser.import_companies
    parser.import_students
    parser.import_internships
  end

  desc 'save all semester to initialize sid'
  task update_semesters: :environment do
    Semester.all.each(&:save)
  end

  desc 'geocode all company addresses'
  task geocode_companies: :environment do
    CompanyAddress.find_each do |ca|
      if ca.latitude.nil?
        result = ca.geocode
        if result.present?
          puts "id: #{ca.id} RESULT: #{result}"
          ca.update_attributes(latitude: result[0], longitude: result[1])
        else
          puts "id: #{ca.id} couldn't geocode"
          puts "address: #{ca.address}"
          s = 'https://imi-map-production.f4.htw-berlin.de/'
          p = 'de/admin/company_addresses/'
          puts "#{s}#{p}#{ca.id}"
          puts
        end
      end
    end
  end
end
