# frozen_string_literal: true

# Helper Methods for Internship stuff
module InternshipsHelper
  def student_name(internship:)
    if internship.student.nil?
      t('active_admin.no_student')
    else
      internship.student.name
    end
  end

  def company_name(internship:)
    if internship.company_address.nil?
      t('active_admin.no_company')
    else
      internship.company_address.company.name
    end
  end
end
