# frozen_string_literal: true

require_relative './08_internships.rb'

def email_for_enrolment_number(enrolment_number:)
  User.email_for(enrolment_number)
  # "s0#{enrolment_number}@htw-berlin.de"
end

def create_student(enrolment_number:)
  Student.create!(
    import_id: Faker::Number.number(digits: 2),
    enrolment_number: enrolment_number,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: email_for_enrolment_number(enrolment_number: enrolment_number),
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
    birthplace: Faker::Address.country
  )
end

def create_company_address
  company = create_company
  geocoded_company_address(company: company)
end

def create_company
  Company.create!(
    name: Faker::Company.name,
    number_employees: Faker::Number.number(digits: 3),
    excluded_from_search: Faker::Boolean.boolean,
    import_id: Faker::Number.number(digits: 1),
    website: Faker::Internet.url(host: 'htw-berlin.de')
  )
end

def geocoded_company_address(company:)
  CompanyAddress.create!(
    company: company,
    street: Faker::Address.street_address,
    zip: Faker::Address.zip,
    city: Faker::Address.city,
    country: Faker::Address.country,
    phone: Faker::PhoneNumber.phone_number,
    latitude: rand(-80..80),
    longitude: rand(-180..180)
  )
end

def create_complete_internship(student:)
  student.create_complete_internship!(
    semester: Semester.all.sample(1).first,
    semester_of_study: rand(4..6)
  )
end

def create_for_seed_data(enrolment_number:, seed_data:)
  if seed_data.with_student
    create_student_with(enrolment_number: enrolment_number,
                        with_internships: seed_data.with_internships,
                        with_user: seed_data.with_user)
  else
    create_only_user(enrolment_number: enrolment_number)
  end
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

def create_only_user(enrolment_number:)
  user = User.create(
    email: email_for_enrolment_number(enrolment_number: enrolment_number),
    password: 'geheim12',
    password_confirmation: 'geheim12',
    role: :user
  )
  user
end

def create_user_for_student(student:)
  user = User.create(email: student.email,
                     password: 'geheim12',
                     password_confirmation: 'geheim12',
                     role: :user,
                     student: student)
  user
end
