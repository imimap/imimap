class UsersController < ApplicationController
  before_filter :check_permission, only: [:new, :create]
  before_filter :check_existing_user, only: [:new, :create]

  def create
    @user = User.new()
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
        redirect_to root_url, error: "Users exists. Please sign in with your email and password"  if student && User.find_by_student_id(student.id)
      end
    end

end
