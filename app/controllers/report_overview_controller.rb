class ReportOverviewController < ApplicationController
  respond_to :html, :json

  before_filter :authorize


  # GET /report_overview
  # GET /report_overview.json
  def index


    @internships = Internship.includes(:company, :student, :semester).where(semester_id: Semester.all)

    @semesters = @internships.map(&:semester).uniq.map{ |s| [s.name, s.id] }


    @companies = @internships.collect(&:company)

    @countries = @companies.collect(&:country)


    @students = @internships.map(&:student).compact.uniq.collect { |o| [o.name] }


    names = params[:name].to_s.upcase
    last_names = params[:last_name].to_s.capitalize
    first_names = params[:first_name].to_s.capitalize
    countries = params[:country].to_s.capitalize


    @internships = @internships.where(:companies => {:country => countries}) if params[:country].present?
    @internships = @internships.where(:students => {:last_name => last_names}) if params[:last_name].present?
    @internships = @internships.where(:students => {:first_name => first_names}) if params[:first_name].present?
    @internships = @internships.where(:semesters => {:name => names}) if params[:name].present?


    respond_to do |format|
      format.html
      format.csv {send_data @internships.to_csv}
    end

  end



end
