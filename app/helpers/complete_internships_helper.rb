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
  def registration_state_from_params(params)
    if params && params['registration_state_id'] && params['registration_state_id'] != '-1'
      RegistrationState.find(params['registration_state_id'])
    else
      return nil
    end
  end
  def internship_state_from_params(params)
    if params && params['internship_state_id'] && params['internship_state_id'] != '-1'
      InternshipState.find(params['internship_state_id'])
    else
      return nil
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

  def set_limit_variables
    @company_search_limit = UserCanSeeCompany
                            .limit(created_by: 'company_search')
    @company_suggest_limit = UserCanSeeCompany
                             .limit(created_by: 'company_suggest')
    @internship_search_limit = UserCanSeeInternship.limit
  end

  def set_semesters
    @semesters = Semester.all.pluck(:name, :id)
  end

  def set_student
    if current_user.student?
      @student = current_user.student
    else
      student = @complete_internship.student
      @student = (student if can?(:read, student))
    end
  end

  def set_active_menu_item
    @active_menu_item = 'cidcontext'
  end

  def complete_internship_title(complete_internship:)
    result = "#{complete_internship.student.try(:first_name)}" \
             " #{complete_internship.student.try(:last_name)}" +
             t('complete_internships.semester') +
             complete_internship.semester.try(:name)
    unless complete_internship.semester_of_study.nil?
      fs = t('activerecord.attributes.complete_internship.semester_of_study')
      result += " (#{complete_internship.semester_of_study}. " \
                "#{fs})"
    end
    result
  end
end
