class ReportOverviewController < ApplicationController
  respond_to :html, :json

  before_filter :authorize




  # GET /report_overview
  # GET /report_overview.json
  def index


    @semesters = Semester.all

    @internships = Internship.all


    #@companies = @internships.collect(&:company)

    #@enrolment_number = @internships.collect(&:enrolment_number)


    #s_id = params[:semester].collect(&:to_i) if params[:semester]

    #@internships = @internships.where(:companies => {:country => params[:country]}) if params[:country].present?

    #@internships = @internships.where(:semester_id => s_id) if s_id.present?


   # @internships_size = @internships.size

    respond_with(@internships)
  end



end
