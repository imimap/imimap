# frozen_string_literal: true

# Prepares Statistic View TBD - delete or create working one
class StatisticController < ApplicationController
  include CompleteInternshipsHelper
  def overview
    return if Semester.count.zero? || Internship.count.zero?

    @semester = semester_from_params(params[:semester_id])
    @semester_options = Semester.pluck(:name, :id)
    @internships = Internship.joins(:company)
                             .where(semester_id: @semester_id)
                             .group(:country).count
  end
end
