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
      if int.student.first_name.nil?
        ci.first_name = t(complete_internship.no_entry)
      else
        ci.first_name = int.student.first_name
      end

      if int.student.last_name.nil?
        ci.last_name = t(complete_internship.no_entry)
      else
        ci.last_name = int.student.last_name
      end

      if int.student.enrolment_number.nil?
        ci.enrolment_number = t(complete_internship.no_entry)
      else
        ci.enrolment_number = int.student.enrolment_number
      end
    end

    def add_company_info(int)
      ci = self
      ci.company = int.company_v2.nil? ? t(complete_internship.no_entry) : int.company_v2.name
      if int.company_address.nil?
        ci.city = t(complete_internship.no_entry)
        ci.country = t(complete_internship.no_entry)
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
      add_internship_state(int)
    end

    def add_internship_state(int)
      ci = self
      ci.internship_state = ''
      if int.internship_state && int.internship_state.name == 'passed'
        ci.internship_state += int.internship_state.name
      else
        add_contract_state(int)
        add_registration_state(int)
        add_certificate_state(int)
      end
    end

    def add_contract_state(int)
      ci = self
      return unless int.contract_state

      ci.internship_state += "Contract: #{int.contract_state.name}; "
    end

    def add_registration_state(int)
      ci = self
      return unless int.registration_state

      ci.internship_state += "Registration: #{int.registration_state.name}; "
    end

    def add_certificate_state(int)
      ci = self
      return unless int.certificate_state

      ci.internship_state += "Certificate: #{int.certificate_state.name}"
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
