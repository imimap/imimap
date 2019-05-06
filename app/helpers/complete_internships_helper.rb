# frozen_string_literal: true

# maybe CompleteInternshipData moves here.
module CompleteInternshipsHelper
  def semester_select_options
    Semester.all.map { |s| [s.name, s.id] }
  end

  def company_address?(internship)
    if internship.company_address.nil?
      false
    else
      internship.company_address.all_company_address_details_filled?
    end
  end

  def company_name_for_checklist(internship)
    if internship.company_address
      internship.company_address.company.name
    else
      t "complete_internships.company"
    end 
  end
end
