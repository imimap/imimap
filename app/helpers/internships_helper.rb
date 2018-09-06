# frozen_string_literal: true

# Helper Methods for Internship stuff
module InternshipsHelper
  CompleteInternship = Struct.new(:first_name,
                                  :last_name,
                                  :enrolment_number,
                                  :company,
                                  :city,
                                  :country,
                                  :start_date,
                                  :end_date)
  def complete_internship(int)
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
      ci.country = int.company_address.country
    end
    ci.start_date = int.start_date
    ci.end_date = int.end_date
    ci
  end
end
