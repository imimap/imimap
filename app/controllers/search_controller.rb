class SearchController < ApplicationController

  def index

    @internships = Internship.all

    @companies = @internships.collect do |x| x.company end

    @countries = @companies.collect do |x| x.country end.distinct

  	@programming_languages = ProgrammingLanguage.order(:name).where(:id => (Internship.joins(:programming_languages).select(:programming_language_id).collect do |x| x.programming_language_id end).distinct).map do |p|
        [p.name, p.id]
      end

    @semesters = Semester.where(:id =>(@internships.collect do |x| x.semester_id end.distinct)).map do |s| [s.name, s.id] end

    @orientations = (Orientation.where(:id => @internships.collect do |x| x.orientation_id end)).distinct.map do |o| [o.name, o.id] end

    @living_costs_max = @internships.collect do |x| x.living_costs end.max

    @salary_max = @internships.collect do |x| x.salary end.max


  end

end
