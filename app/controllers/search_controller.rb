# frozen_string_literal: true

# TBD might be reused for the new search.
class SearchController < ApplicationController
  def index
    @internships = Internship.all

    @companies = @internships.collect(&:company)

    @countries = @companies.collect(&:country).distinct

    @programming_languages = ProgrammingLanguage.order(:name).where(id: Internship.joins(:programming_languages).select(:programming_language_id).collect(&:programming_language_id).distinct).map do |p|
      [p.name, p.id]
    end

    @semesters = Semester.where(id: @internships.collect(&:semester_id).distinct).map { |s| [s.name, s.id] }

    @orientations = Orientation.where(id: @internships.collect(&:orientation_id)).distinct.map { |o| [o.name, o.id] }

    @living_costs_max = @internships.collect(&:living_costs).max

    @salary_max = @internships.collect(&:salary).max
  end
end
