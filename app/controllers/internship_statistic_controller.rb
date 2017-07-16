class InternshipStatisticController < ApplicationController
  def index
    @internship = Internship.first
    @internships = Internship.all
    @companies = Company.all
    @semesters = Semester.all
    @semester_id = params[:semester_id]
  end

  def create
    redirect_to action: "index", semester_id: params[:semester_id]
  end 
end