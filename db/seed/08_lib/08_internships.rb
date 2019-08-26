# frozen_string_literal: true

def create_internship(complete_internship:, company_address:)
  intern_rating_id = InternshipRating.first
  Internship.create!(
    title: Faker::Job.title,
    salary: Faker::Number.number(digits: 4),
    internship_rating_id: intern_rating_id,
    working_hours: Faker::Number.number(digits: 2),
    living_costs: Faker::Number.number(digits: 3),
    student: complete_internship.student,
    complete_internship: complete_internship,
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

    comment: Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote,
    certificate_to_prof: Faker::Date.forward(30),
    certificate_signed_by_prof: Faker::Date.forward(50),
    certificate_signed_by_internship_officer: Faker::Date.backward(5)
  )
end
