class StatisticController < ApplicationController
  
  def overview
    @internships = Internship.all
    @companies = Company.all
    @semesters = Semester.all

    if params[:semester_id] == nil
      @semester_id = Semester.last.id
    else
      @semester_id = params[:semester_id]
    end
  end

end
