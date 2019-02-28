# frozen_string_literal: true

# Wasn't here for some reason; recreated to have a place for the
# permitted attributes
class StudentsController < ApplicationResourceController
  def self.permitted_params
    %i[first_name
       last_name
       first_name
       enrolment_number
       birthplace
       birthday
       email]
  end

  def show
    @user = User.find(params[:id])
    @student = @user.student
    # TBD centralize logic for users that are not students
    assign_show_attributes(@student)
  end

  def update
    @user = User.find(params[:id])
    @student = @user.student
    if @student.update_attributes(student_params)
      flash[:success] = 'Profil geupdated'
      redirect_to @student
    else
      render 'show'
    end
  end

  private

  def student_params
    params.require(:student)
          .permit(:first_name, :last_name, :birthday, :birthplace, :email)
  end

  def assign_show_attributes(student:)
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
