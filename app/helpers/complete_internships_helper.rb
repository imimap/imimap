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
end
