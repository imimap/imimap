module CompleteInternshipHelper
  # frozen_string_literal: true
  def CompleteInternship.from(int)
    ci = CompleteInternship.new
    if int.student.nil?
      ci.first_name = '(no student)'
      ci.last_name = '(no student)'
      ci.enrolment_number = '(none)'
    else
      ci.first_name = int.student.first_name
      ci.last_name = int.student.last_name
      ci.enrolment_number = int.student.enrolment_number
    end
    ci.company = if int.company_v2.nil?
                   '(no company)'
                 else
                   int.company_v2.name
                 end
    if int.company_address.nil?
      ci.city = '(no city)'
      ci.country = '(no country)'
    else
      ci.city = int.company_address.city
      ci.country = int.company_address.country_name
    end
    ci.start_date = int.start_date
    ci.end_date = int.end_date

    ci.internship_state = int.internship_state.name if int.internship_state
    ci.contract_state = int.contract_state.name if int.contract_state
    ci.registration_state = int.registration_state.name if int.registration_state
    ci.certificate_state = int.certificate_state.name if int.certificate_state
    ci
  end

  def CompleteInternship.to_csv(complete_internships)
    CSV.generate do |csv|
      csv << COMPLETE_INTERNSHIP_MEMBERS
      complete_internships.each do |ci|
        csv << ci.to_a
      end
    end
  end

end
