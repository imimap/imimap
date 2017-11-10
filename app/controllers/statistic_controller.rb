class StatisticController < ApplicationController

  def overview
    unless (Semester.count == 0 || Internship.count == 0)
      if params[:semester_id] == nil
        @semester_id = Semester.last.id
      else
        @semester_id = params[:semester_id].to_i
      end
      @semester = Semester.find(@semester_id)
      @semester_options = Semester.all.map { |s| [s.name, s.id] }
      @internships = Internship.joins(:company).where(semester_id: @semester_id).group(:country).count
    end
  end
end
