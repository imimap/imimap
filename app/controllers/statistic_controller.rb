# frozen_string_literal: true

class StatisticController < ApplicationController
  def overview
    unless Semester.count == 0 || Internship.count == 0
      @semester_id = if params[:semester_id].nil?
                       Semester.last.id
                     else
                       params[:semester_id].to_i
                     end
      @semester = Semester.find(@semester_id)
      @semester_options = Semester.all.map { |s| [s.name, s.id] }
      @internships = Internship.joins(:company).where(semester_id: @semester_id).group(:country).count
    end
  end
end
