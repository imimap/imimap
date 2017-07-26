Internship.destroy_all

intern_rating_id = InternshipRating.first
n=1
10.times do
  r_o = rand(Orientation.count)+1
  r_c_s = rand(ContractState.count)+1
  r_r_s = rand(RegistrationState.count)+1
  r_re_s = rand(ReportState.count)+1
  r_ce_s = rand(CertificateState.count)+1
  r_p_s = rand(PaymentState.count)+1
  r_i_s = rand(InternshipState.count)+1
  r_student_id = rand(Student.count)+1
  r_company_id = rand(Company.count)+1
  r_readingProf_id = rand(ReadingProf.count)+1
  r_semester_id = rand(Semester.count)+1


  Internship.create!(
      title: Faker::Job.title,
      salary: Faker::Number.number(4),
      internship_rating_id: intern_rating_id,
      working_hours: Faker::Number.number(2),
      living_costs: Faker::Number.number(3),
      company_id: r_company_id,
      student_id: r_student_id,
      semester_id: r_semester_id,
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
      reading_prof_id: r_readingProf_id,
      certificate_to_prof: Faker::Date.forward(30),
      certificate_signed_by_prof: Faker::Date.forward(50),
      certificate_signed_by_internship_officer: Faker::Date.backward(5)
    )
  n+=1
end