# frozen_string_literal: true

# Controller for UserCanSeeCompanies
class UserCanSeeInternshipsController < InheritedResources::Base
  authorize_resource

  def reset_limit
    user = Student.find_by(id: params[:student_id]).try(:user)
    return if user.nil?

    if UserCanSeeInternship.where(user_id: user.id).destroy_all
      flash[:success] = 'Reset successful'
    end
    ci = CompleteInternship.find_by(student_id: params[:student_id])
    redirect_to ci
  end

  private

  def user_can_see_internship_params
    params.require(:user_can_see_internship).permit(:internship_id, :user_id)
  end
  
end
