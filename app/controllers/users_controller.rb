# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationResourceController
  before_action :check_permission, only: %i[new create]
  before_action :check_existing_user, only: %i[new create]

  def create
    @user = User.new(user_params)
    @user.save!
  end

  def show
    @user = User.find(params[:id])
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

  def check_permission
    redirect_to root_url unless session[:enrolment_number].present?
  end

  def check_existing_user
    return unless session[:enrolment_number]

    student = Student.where(enrolment_number: session[:enrolment_number]).first
    return unless student && User.find_by_student_id(student.id)

    redirect_to root_url,
                error:
                'User exists. Please sign in with your email and password'
  end

  def user_params
    params.require(:user).permit(User::EDITABLE_ATTRIBUTES_ALL)
  end
end
