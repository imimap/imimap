class ReportOverviewController < ApplicationController
  respond_to :html, :json

  before_filter :authorize


  # GET /report_overview
  # GET /report_overview.json
  def index


   @internships = Internship.includes(:company, :student, :semester).where(semester_id: Semester.all)

    #@internships = Internship.search(params[:search])


    @semesters = @internships.map(&:semester).uniq.map{ |s| [s.name, s.id] }


   @companies = @internships.collect(&:company)

   @countries = @companies.collect(&:country)

    #@students = @internships.collect(&:student).compact.uniq.collect { |o| [o.name, o.id] }

    #@students = @internships.map(&:student).compact.uniq.collect { |o| [o.name, o.id] }

    @students = @internships.map(&:student).compact.uniq.collect { |o| [o.name] }



    #semesters = params[:semester].collect(&:to_i) if params[:semester]
   names = params[:name].to_s.upcase
    #students = params[:student].collect(&:to_i) if params[:student]
    #students = params[:student].to_i if params[:student]
   #job_titles = params [:title].to_s.capitalize
   last_names = params[:last_name].to_s.capitalize
   first_names = params[:first_name].to_s.capitalize
   countries = params[:country].to_s.capitalize




    #buat munculin tabel stlh search

    #@internships = @internships.where(:student_id => students) if students.present?
   #@internships = @internships.where(:companies => {:country => params[:country].to_s}) if params[:country].present?

   @internships = @internships.where(:companies => {:country => countries}) if params[:country].present?

   #@internships = @internships.where(:student => students) if students.present?

   @internships = @internships.where(:students => {:last_name => last_names}) if params[:last_name].present?
   @internships = @internships.where(:students => {:first_name => first_names}) if params[:first_name].present?
   #@internships = @internships.where(:title => job_titles) if params[:title].present?



   @internships = @internships.where(:semesters => {:name => names}) if params[:name].present?


    respond_with(@internships)

  end



end
