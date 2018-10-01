# frozen_string_literal: true

require_relative './08_addresses.rb'
def create_internship(student:, company_address:)
  Semester.find(Semester.pluck(:id).sample)

  intern_rating_id = InternshipRating.first
  Internship.create!(
    title: Faker::Job.title,
    salary: Faker::Number.number(4),
    internship_rating_id: intern_rating_id,
    working_hours: Faker::Number.number(2),
    living_costs: Faker::Number.number(3),
    student: student,
    company_address: company_address,
    # company: company_address.company,
    start_date: Faker::Date.backward(120),
    end_date: Faker::Date.forward(50),
    operational_area: Faker::Job.title,
    tasks: Faker::HitchhikersGuideToTheGalaxy.quote,
    supervisor_name: Faker::Name.last_name,
    supervisor_email: Faker::Internet.email,
    semester: Semester.all.sample(1).first,
    orientation: Orientation.all.sample(1).first,
    registration_state: RegistrationState.all.sample(1).first,
    contract_state: ContractState.all.sample(1).first,
    report_state: ReportState.all.sample(1).first,
    certificate_state: CertificateState.all.sample(1).first,
    payment_state: PaymentState.all.sample(1).first,
    internship_state: InternshipState.all.sample(1).first,
    reading_prof: ReadingProf.all.sample(1).first,

    comment: Faker::HitchhikersGuideToTheGalaxy.marvin_quote,
    certificate_to_prof: Faker::Date.forward(30),
    certificate_signed_by_prof: Faker::Date.forward(50),
    certificate_signed_by_internship_officer: Faker::Date.backward(5)
  )
end

def email_for_enrolment_number(enrolment_number:)
  "s0#{enrolment_number}@student.htw-berlin.de"
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

def create_student(enrolment_number:, with_internship:, with_user:)
  student = Student.create!(
    import_id: Faker::Number.number(1),
    enrolment_number: enrolment_number,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: email_for_enrolment_number(enrolment_number: enrolment_number),
    birthday: Faker::Date.birthday(18, 65),
    birthplace: Faker::Address.country
  )

  create_user_for_student(student: student) if with_user

  return unless with_internship
  company = Company.create!(
    name: Faker::Company.name,
    number_employees: Faker::Number.number(3),
    excluded_from_search: Faker::Boolean.boolean,
    import_id: Faker::Number.number(1),
    website: Faker::Internet.url('example.com')
  )

  company_address = geocoded_address(company: company)

  create_internship(student: student, company_address: company_address)
end
