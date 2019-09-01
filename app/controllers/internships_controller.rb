# frozen_string_literal: true

# The Internships controller
class InternshipsController < ApplicationResourceController
  include ApplicationHelper
  include CompleteInternshipsHelper
  respond_to :html, :json
  before_action :programming_languages, :orientations, only: %i[new edit update]
  before_action :set_internship,
                only: %i[edit show update rating destroy]
  before_action :set_semesters, only: %i[new edit create]
  # GET /internships
  # GET /internships.json

  include InternshipsHelper
  include CompleteInternshipDataHelper

  def index
    @semester = semester_from_params(params)
    @semester_options = semester_select_options

    internships = Internship.where(semester: @semester)
    @internship_count = internships.count
    # make rails load the file
    CompleteInternshipData if @internship_count.zero?
    @complete_internships = internships.map do |i|
      CompleteInternshipData.from(i)
    end
    @field_names = COMPLETE_INTERNSHIP_MEMBERS
    @header_names = COMPLETE_INTERNSHIP_MEMBERS.map do |m|
      t("complete_internship.#{m}")
    end
    respond_to do |format|
      format.html
      format.csv do
        send_data CompleteInternshipData.to_csv(@complete_internships)
      end
      # see https://github.com/straydogstudio/axlsx_rails
      # @header_names and @complete_internships are used in
      # app/views/internships/index.xlsx.axlsx
      format.xlsx
    end
  end

  def new
    byebug
    # TBD ST: what is this?
    # creation of company Address redirects here.
    # there is no handover of the company_address_id
    # that should have just been created - oh, company_last
    # should do that. needs to be fixed.
    @internship = Internship.new
    # @company = @internship.build_company
    @student = @internship.student
    @company_address = CompanyAddress.new
    current_user
    @reading_prof = ReadingProf.new
    @company_last = Company.last
  end

  def create
    @internship = Internship.new(internship_params)

    @internship.user_id = current_user.id
    # @internship.student_id = current_user.student_id
    @complete_internship = current_user.student.complete_internship
    @internship.complete_internship = @complete_internship

    respond_to do |format|
      if @internship.save
        format.html do
          redirect_to @complete_internship,
                      notice: 'Your internship was successfully created!'
        end
      else
        format.html { render action: 'new' }

      end
    end
  end

  def create_empty
    @internship = Internship.new(internship_params)

    @internship.user_id = current_user.id
    @internship.student_id = current_user.student_id
    @internship.semester_id = semester.current
    @internship.save!
    redirect_to show_complete_internship
  end

  # GET /internships/1
  # GET /internships/1.json
  def show
    byebug
    @company = @internship.company_v2
    # TBD ST  @company = @internship.company_address.company
    @other_internships = []
    # @company.internships.reject do |x|
    #  x.id == @internship.id
    # end.reject { |i| i.completed == false }

    respond_to do |format|
      format.html
      name = @current_user.student.last_name
      format.pdf do
        pdf = InternshipPdf.new(@internship)
        send_data pdf.render,
                  filename: "internship_registration_#{name}.pdf",
                  type: 'application/pdf'
      end
    end
  end

  def rating; end

  # GET /internships/1/edit
  def edit
    return unless @current_user.student

    @internship = @current_user.student
                               .complete_internship
                               .internships
                               .find(params[:id])
    @profs = ReadingProf.order(:id).map { |p| [p.name, p.id] }
  end

  # PUT /internships/1
  # PUT /internships/1.json
  def update
    attributes = internship_params
    @internship = @current_user.student
                               .complete_internship
                               .internships
                               .find(params[:id])
    if @internship.update(attributes)
      @internship.update(completed: true)
      flash[:notice] = 'Internship was successfully updated.'
      respond_with(@current_user.student
                                 .complete_internship)
    else
      @rating = @internship.build_internship_rating
      render :edit, notice: 'Please fill in all fields'
    end
  end

  # DELETE /internships/1
  # DELETE /internships/1.json
  def destroy
    @internship.destroy

    respond_to do |format|
      format.html { redirect_to internships_url }
      format.json { head :no_content }
    end
  end

  # If the user has no internship, the system asks him/her to create a new one
  # else the internship details are shown
  def internship_data
    @internships = if current_user.student.nil?
                     []
                   else
                     current_user.student.internships
                   end

    if @internships.any?
      redirect_to @internships.first
    else
      render :no_internship_data
    end
  end

  def self.permitted_params
    a = []
    a << MODEL_ATTRIBUTES
    a << BASIC_ATTRIBUTES
    a << STATE_ATTRIBUTES
    a << REPORT_ATTRIBUTES
    a << NOT_USED_ATTRIBUTES
    a << WORK_DESCRIPTION_ATTRIBUTES
    a << SUPERVISOR_ATTRIBUTES
    a << REVIEW_ATTRIBUTES
    # these should be last because it's a hash!!!
    a << NESTED_ATTRIBUTES
    a
  end

  MODEL_ATTRIBUTES = %i[company_address_id complete_internship_id].freeze
  BASIC_ATTRIBUTES = %i[semester_id start_date end_date].freeze
  STATE_ATTRIBUTES = %i[internship_state_id
                        contract_state_id
                        registration_state_id
                        report_state_id payment_state_id
                        reading_prof_id
                        certificate_signed_by_internship_officer
                        certificate_signed_by_prof
                        certificate_state_id
                        certificate_to_prof].freeze
  REPORT_ATTRIBUTES = [:internship_report].freeze
  NOT_USED_ATTRIBUTES = %i[completed user_id].freeze
  WORK_DESCRIPTION_ATTRIBUTES = %i[operational_area
                                   orientation_id
                                   description
                                   title
                                   tasks].freeze
  SUPERVISOR_ATTRIBUTES = %i[supervisor_email
                             supervisor_name
                             supervisor_phone].freeze

  REVIEW_ATTRIBUTES = %i[comment
                         recommend
                         working_hours
                         salary
                         living_costs
                         internship_rating_attributes
                         internship_rating_id
                         email_public].freeze

  NESTED_ATTRIBUTES = { programming_language_ids: [] }.freeze

  # title (job title, usually not used, not part of active admin)
  # orientation_id (not used)

  private

  def set_internship
    current_user.accessible_internships.find(params[:id])
  end

  def internship_params
    params.require(:internship).permit(
      InternshipsController.permitted_params
    )
  end

  def set_semesters
    @semesters = Semester.all.pluck(:name, :id)
  end
end
