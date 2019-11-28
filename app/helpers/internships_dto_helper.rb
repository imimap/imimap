# frozen_string_literal: true

# uninitialized constant InternshipsController::InternshipsDtoHelper
# Composes all Internship Information in one Class to pass to the view
module InternshipsDtoHelper
  COMPLETE_INTERNSHIP_MEMBERS = %i[first_name
                                   last_name
                                   enrolment_number
                                   company
                                   city
                                   country
                                   start_date
                                   end_date
                                   internship_state].freeze
  # Data Class for the view.
  class InternshipsDto
    attr_accessor(*COMPLETE_INTERNSHIP_MEMBERS)

    def to_a
      attribute_array
    end

    def attribute_array
      COMPLETE_INTERNSHIP_MEMBERS.map do |attribute_name|
        value = send(attribute_name)
        value.nil? ? 0 : value
      end
    end

    def <=>(other)
      attribute_array <=> other.attribute_array
    end

    # InternshipsDto = Struct.new(*COMPLETE_INTERNSHIP_MEMBERS) do
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
      ci.company = int.company_name
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

  def InternshipsDto.from(int)
    ci = InternshipsDto.new
    ci.add_student_info(int)
    ci.add_company_info(int)
    ci.add_status_info(int)
    ci
  end

  def InternshipsDto.to_csv(complete_internships)
    CSV.generate do |csv|
      csv << COMPLETE_INTERNSHIP_MEMBERS
      complete_internships.each do |ci|
        csv << ci.to_a
      end
    end
  end
end
