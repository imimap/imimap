# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :check_permission, only: %i[new create]
  before_action :check_existing_user, only: %i[new create]

  def create
    @user = User.new(user_params)
    @user.save!
  end

  def show
    @user = User.find(params[:id])
    @internships = @user.student.internships
    @comments = @user.user_comments
  end

  private

  def check_permission
    redirect_to root_url unless session[:enrolment_number].present?
  end

  def check_existing_user
    if session[:enrolment_number]
      student = Student.where(enrolment_number: session[:enrolment_number]).first
      redirect_to root_url, error: 'Users exists. Please sign in with your email and password' if student && User.find_by_student_id(student.id)
    end
  end

  def user_params
    #  params.require(:user).permit(User::EDITABLE_ATTRIBUTES)
    #  params.require(:user).permit(:email, :mailnotif, :publicmail, :student_id, :role, :password, :password_confirmation)
    params.require(:user).permit!
  end
end
