# frozen_string_literal: true

Student.destroy_all
Internship.destroy_all
Company.destroy_all
CompanyAddress.destroy_all


def create_student(enrolment_number: , with_internship: )
  student = Student.create!(
    import_id: Faker::Number.number(1),
    enrolment_number: enrolment_number,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    birthday: Faker::Date.birthday(18, 65),
    birthplace: Faker::Address.country
  )
  if (with_internship)
    company = Company.create!(
      name: Faker::Company.name,
      number_employees: Faker::Number.number(3),
      blacklisted: Faker::Boolean.boolean,
      import_id: Faker::Number.number(1),
      website: Faker::Internet.url('example.com')
    )

    company_address = CompanyAddress.create!(
      company_id: company.id,
      street: Faker::Address.street_address,
      zip: Faker::Address.zip,
      city: Faker::Address.city,
      country: Faker::Address.country,
      phone: Faker::PhoneNumber.phone_number
    )

    r_o = rand(Orientation.count) + 1
    r_c_s = rand(ContractState.count) + 1
    r_r_s = rand(RegistrationState.count) + 1
    r_re_s = rand(ReportState.count) + 1
    r_ce_s = rand(CertificateState.count) + 1
    r_p_s = rand(PaymentState.count) + 1
    r_i_s = rand(InternshipState.count) + 1
    # r_student = Student.last
    # company = Company.last
    reading_prof = ReadingProf.find(ReadingProf.pluck(:id).sample)
    reading_prof_id = reading_prof.id if reading_prof
    semester = Semester.find(Semester.pluck(:id).sample)

    intern_rating_id = InternshipRating.first

    Internship.create!(
      title: Faker::Job.title,
      salary: Faker::Number.number(4),
      internship_rating_id: intern_rating_id,
      working_hours: Faker::Number.number(2),
      living_costs: Faker::Number.number(3),
      company: company,
      student: student,
      company_address: company_address,
      semester_id: semester.id,
      start_date: Faker::Date.backward(120),
      end_date: Faker::Date.forward(50),
      operational_area: Faker::Job.title,
      tasks: Faker::ChuckNorris.fact,
      orientation_id: r_o,
      supervisor_name: Faker::Name.last_name,
      supervisor_email: Faker::Internet.email,
      registration_state_id: r_r_s,
      contract_state_id: r_c_s,
      report_state_id: r_re_s,
      certificate_state_id: r_ce_s,
      payment_state_id: r_p_s,
      internship_state_id: r_i_s,
      comment: Faker::ChuckNorris.fact,
      reading_prof_id: reading_prof_id,
      certificate_to_prof: Faker::Date.forward(30),
      certificate_signed_by_prof: Faker::Date.forward(50),
      certificate_signed_by_internship_officer: Faker::Date.backward(5)

    )
  end
end

for er in 20001..20020
  create_student(enrolment_number: er, with_internship: true)
end

for er in 30001..30020
  create_student(enrolment_number: er, with_internship: false)
end
