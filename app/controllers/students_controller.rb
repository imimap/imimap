# frozen_string_literal: true

# Student editing for Students
class StudentsController < ApplicationResourceController
  before_action :set_student, only: %i[show update]
  before_action :set_complete_internship, only: %i[show update]
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
    assign_show_attributes(@student)
  end

  def update
    @student = Student.find(params[:id])
    @user = @student.user
    flash[:success] = 'Profil geupdated' if @student.update(student_params)
    render 'show'
  end

  private

  def set_student
    # @student = current_user.student
    @student = Student.find(params[:id])
  end
  def set_complete_internship
    if params[:complete_internship_id]
      @complete_internship_id = params[:complete_internship_id]
    else
      @complete_internship_id = @student.complete_internship.id
    end
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
