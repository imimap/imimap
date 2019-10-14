# frozen_string_literal: true

# maybe CompleteInternshipData moves here.
module CompleteInternshipsHelper
  def semester_select_options(show_all: false)
    semester = Semester.all.map { |s| [s.name, s.id] }
    if show_all
      semester.unshift(['All', -1])
    else
      semester
    end
  end

  def semester_from_params(params)
    if params && params['semester_id'] && params['semester_id'] != '-1'
      Semester.find(params['semester_id'])
    else
      Semester.current
    end
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
      t 'complete_internships.company'
    end
  end
end
