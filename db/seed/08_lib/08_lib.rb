# frozen_string_literal: true

require_relative './08_addresses.rb'
require_relative './08_internships.rb'

def email_for_enrolment_number(enrolment_number:)
  "s0#{enrolment_number}@htw-berlin.de"
end

def create_user_for_student(student:)
  user = User.create(email: student.email,
                     password: 'geheim12',
                     password_confirmation: 'geheim12',
                     role: :user,
                     student: student)
  puts "created user for student #{user.email}"
  user
end

def create_student(enrolment_number:)
  Student.create!(
    import_id: Faker::Number.number(1),
    enrolment_number: enrolment_number,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: email_for_enrolment_number(enrolment_number: enrolment_number),
    birthday: Faker::Date.birthday(18, 65),
    birthplace: Faker::Address.country
  )
end

def create_company_address
  company = create_company
  GeocodedAddresses.geocoded_company_address(company: company)
end

def create_company
  Company.create!(
    name: Faker::Company.name,
    number_employees: Faker::Number.number(3),
    excluded_from_search: Faker::Boolean.boolean,
    import_id: Faker::Number.number(1),
    website: Faker::Internet.url('example.com')
  )
end

def create_complete_internship(student:)
  student.create_complete_internship(
    semester_id: Semester.all.sample(1).first
  )
end

def create_student_with(enrolment_number:, with_internships:, with_user:)
  student = create_student(enrolment_number: enrolment_number)
  create_user_for_student(student: student) if with_user
  return if with_internships.zero?

  complete_internship = create_complete_internship(student: student)
  with_internships.times do
    company_address = create_company_address
    create_internship(complete_internship: complete_internship,
                      company_address: company_address)
  end
end
