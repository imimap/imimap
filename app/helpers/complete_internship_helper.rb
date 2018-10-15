# frozen_string_literal: true

# Composes all Internship Information in one Class to pass to the view
module CompleteInternshipHelper
  COMPLETE_INTERNSHIP_MEMBERS = %i[first_name
                                   last_name
                                   enrolment_number
                                   company
                                   city
                                   country
                                   start_date
                                   end_date
                                   internship_state].freeze
  CompleteInternship = Struct.new(*COMPLETE_INTERNSHIP_MEMBERS) do
    def add_student_info(int)
      ci = self
      if int.student.nil?
        ci.first_name = '(no student)'
        ci.last_name = '(no student)'
        ci.enrolment_number = '(none)'
      else
        ci.first_name = int.student.first_name
        ci.last_name = int.student.last_name
        ci.enrolment_number = int.student.enrolment_number
      end
    end

    def add_company_info(int)
      ci = self
      ci.company = int.company_v2.nil? ? '(no company)' : int.company_v2.name
      if int.company_address.nil?
        ci.city = '(no city)'
        ci.country = '(no country)'
      else
        ci.city = int.company_address.city
        ci.country = int.company_address.country_name
      end
    end

    def add_status_info(int)
      ci = self
      ci.start_date = int.start_date
      ci.end_date = int.end_date
      ci.internship_state = ''
      if int.internship_state && int.internship_state.name == 'passed'
        ci.internship_state += int.internship_state.name
      else
        if int.contract_state
          ci.internship_state += "Contract: #{int.contract_state.name}; "
        end
        if int.registration_state
          ci.internship_state += "Registration: #{int.registration_state.name}; "
        end
        if int.certificate_state
          ci.internship_state += "Certificate: #{int.certificate_state.name}"
        end
      end
    end
  end

  def CompleteInternship.from(int)
    ci = CompleteInternship.new
    ci.add_student_info(int)
    ci.add_company_info(int)
    ci.add_status_info(int)
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
