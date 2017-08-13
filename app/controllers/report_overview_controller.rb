class ReportOverviewController < ApplicationController
  respond_to :html, :json

  before_filter :authorize




  # GET /report_overview
  # GET /report_overview.json
  def index

    @internships = Internship.includes(:company).where(semester_id: Semester.all)

    @companies = @internships.collect(&:company)

    @countries = @companies.collect(&:country)

    @semesters = @internships.map(&:semester).uniq.map{ |s| [s.name, s.id] }


    @students = @internships.collect(&:student).compact.uniq.collect { |o| [o.name, o.id] }


    semesters = params[:semester].collect(&:to_i) if params[:semester]
    students = params[:student].collect(&:to_i) if params[:student]

    #buat munculin tabel stlh search

    @internships = @internships.where(:student_id => students) if students.present?

    @internships = @internships.where(:semester_id => semesters) if semesters.present?


    respond_with(@internships)
  end



end
