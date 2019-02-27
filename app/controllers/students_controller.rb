# frozen_string_literal: true

# Wasn't here for some reason; recreated to have a place for the permitted attributes
class StudentsController < ApplicationResourceController
  def self.permitted_params
    %i[first_name last_name first_name enrolment_number birthplace birthday email]
  end

  def show
    @user = User.find(params[:id])
    @student = @user.student
    # TBD centralize logic for users that are not students
    if (s = @student)
      @internships = s.internships
      @user_first_name = s.first_name
      @user_last_name = s.last_name
    else
      @internships = []
      @user_first_name = 'not a student'
      @user_last_name = @user.email
    end
  end

  def update
    @user = User.find(params[:id])
    @student = @user.student
    if @student.update_attributes(student_params)
      flash[:success] = "Profil geupdated"
      redirect_to @student
    else
      render 'show'
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :birthday, :birthplace, :email)
  end

end
