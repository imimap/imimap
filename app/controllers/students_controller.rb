# frozen_string_literal: true

# Student editing for Students
class StudentsController < ApplicationResourceController
  before_action :set_student, only: %i[show update]
  authorize_resource
  include StudentsHelper
  def self.permitted_params
    %i[first_name
       last_name
       first_name
       enrolment_number
       birthplace
       birthday
       email
       private_email]
  end

  def show
    @student = Student.find(params[:id])
    @user = @student.user
    # TBD centralize logic for users that are not students
    assign_show_attributes(@student)
  end

  def update
    @student = Student.find(params[:id])
    @user = @student.user
    if @student.update(student_params)
      flash[:success] = 'Profil geupdated'
    end
    render 'show'
  end

  private

  def set_student
    # @student = current_user.student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student)
          .permit(StudentsController.permitted_params)
  end

  def assign_show_attributes(student)
    if student.nil?
      @internships = []
      @user_first_name = 'not a student'
      @user_last_name = @user.email
    else
      @internships = student.internships
      @user_first_name = student.first_name
      @user_last_name = student.last_name
    end
  end
end
