# frozen_string_literal: true

# Helper for CompleteInternships
module CompleteInternshipsHelper
  include CompleteInternshipsChecklistPageflow

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

  def complete_internship_from_params
    if params[:complete_internship].nil?
      CompleteInternship.new
    else
      CompleteInternship.new(complete_internship_params)
    end
  end

  def complete_internship_params
    params.require(:complete_internship).permit(
      CompleteInternshipsController.permitted_params
    )
  end

  def viewed_companies_search
    if @user.nil?
      0
    else
      UserCanSeeCompany.number_of_viewed_companies_for_user(
        user: @user,
        created_by: 'company_search'
      )
    end
  end

  def viewed_companies_suggest
    if @user.nil?
      0
    else
      UserCanSeeCompany.number_of_viewed_companies_for_user(
        user: @user,
        created_by: 'company_suggest'
      )
    end
  end

  def viewed_internships_search
    if @user.nil?
      0
    else
      UserCanSeeInternship.number_of_viewed_internships_for_user(user: @user)
    end
  end
end
