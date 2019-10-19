# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationResourceController
  def show
    @user = current_user
    # TBD centralize logic for users that are not students
    if (s = @user.student)
      @internships = s.internships
      @user_first_name = s.first_name
      @user_last_name = s.last_name
    else
      @internships = []
      @user_first_name = 'not a student'
      @user_last_name = @user.email
    end
  end

  private

  def user_params
    params.require(:user).permit(User::EDITABLE_ATTRIBUTES_ALL)
  end
end
