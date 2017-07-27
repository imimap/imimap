class InternshipStatisticController < ApplicationController
  before_filter :authorize
  def index
    @internship = Internship.first
    @internships = Internship.all
    @companies = Company.all
    @semesters = Semester.all
    if params[:semester_id] == nil
      @semester_id = Semester.last.id
    else
      @semester_id = params[:semester_id]
    end
  end

  def create
    redirect_to action: "index", semester_id: params[:semester_id]
  end
end