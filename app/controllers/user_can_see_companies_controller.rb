# frozen_string_literal: true

# Controller for UserCanSeeCompanies
class UserCanSeeCompaniesController < InheritedResources::Base
  authorize_resource

  def reset_limit_search
    user = Student.find_by(id: params[:student_id]).try(:user)
    return if user.nil?

    if UserCanSeeCompany.where(
      user_id: user.id,
      created_by: 'company_search'
    ).destroy_all
      flash[:success] = 'Reset successful'
    end
    ci = CompleteInternship.find_by(student_id: params[:student_id])
    redirect_to ci
  end

  def reset_limit_suggest
    user = Student.find_by(id: params[:student_id]).try(:user)
    return if user.nil?

    if UserCanSeeCompany.where(
      user_id: user.id,
      created_by: 'company_suggest'
    ).destroy_all
      flash[:success] = 'Reset successful'
    end
    ci = CompleteInternship.find_by(student_id: params[:student_id])
    redirect_to ci
  end

  private

  def user_can_see_company_params
    params.require(:user_can_see_company).permit(:company_id,
                                                 :user_id,
                                                 :created_by)
  end
end
