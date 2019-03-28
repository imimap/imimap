# frozen_string_literal: true

# Student editing for Students
class StudentsController < ApplicationResourceController
  before_action :set_student, only: %i[show update]
  authorize_resource
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

  def show; end

  def update
    if @student.update_attributes(student_params)
      flash[:success] = 'Profil geupdated'
      redirect_to @student
    else
      render 'show'
    end
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
end
