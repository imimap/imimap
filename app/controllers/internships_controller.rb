# frozen_string_literal: true

class InternshipsController < ApplicationResourceController
  respond_to :html, :json
  before_action :programming_languages, :orientations, only: %i[new edit update]

  before_action :authorize_internship, only: %i[edit update destroy rating]
  # GET /internships
  # GET /internships.json

  include InternshipsHelper
  def index
    authorize! :list, Internship
    @internship_count = Internship.all.count
  end

  def new
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
    @internship.student_id = current_user.student_id

    respond_to do |format|
      if @internship.save
        format.html { redirect_to @internship, notice: 'Your internship was successfully created!' }
        format.json { render json: @internship, status: :created, location: @internship }
      else
        format.html { render action: 'new' }
        format.json { render json: @internship.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /internships/1
  # GET /internships/1.json
  def show
    @internship = Internship.find(params[:id])
    @comment = UserComment.new
    @answer = Answer.new
    @favorite = Favorite.where(internship_id: @internship.id, user_id: current_user.id)[0]
    @company = @internship.company_v2
    # TBD ST  @company = @internship.company_address.company
    @other_internships = @company.internships.reject { |x| x.id == @internship.id }.reject { |i| i.completed == false }

    @user_comments = @internship.user_comments.order('created_at DESC')

    respond_to do |format|
      format.html
      format.pdf do
        pdf = InternshipPdf.new(@internship)
        send_data pdf.render, filename: "Internship Registration Form #{@current_user.student.last_name}.pdf",
                              type: 'application/pdf'
      end
    end
  end

  def rating
    @internship = Internship.find(params[:id])
  end

  # GET /internships/1/edit
  def edit
    @internship = Internship.find(params[:id])
    @company = @internship.company_v2
    @rating = @internship.internship_rating
  end

  # PUT /internships/1
  # PUT /internships/1.json
  def update
    @internship = Internship.find(params[:id])
    attributes = internship_params
    attributes.delete(:company_id) # make internship company readonly by schlubbi
    if @internship.update_attributes(attributes)
      @internship.update_attributes(completed: true)
      flash[:notice] = 'Internship was successfully updated.'
      respond_with(@internship)
    else
      @rating = @internship.build_internship_rating
      render :edit, notice: 'Please fill in all fields'
    end
  end

  # DELETE /internships/1
  # DELETE /internships/1.json
  def destroy
    @internship = Internship.find(params[:id])
    @internship.destroy

    respond_to do |format|
      format.html { redirect_to internships_url }
      format.json { head :no_content }
    end
  end

  # If the user has no internship, the system asks him/her to create a new one
  # else the internship details are shown
  def internship_data
    @internships = current_user.student.nil? ? [] : current_user.student.internships

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
    a << NESTED_ATTRIBUTES
    a << SUPERVISOR_ATTRIBUTES
    a << REVIEW_ATTRIBUTES
    a
  end

  MODEL_ATTRIBUTES = %i[student_id company_address_id].freeze
  BASIC_ATTRIBUTES = %i[semester_id start_date end_date].freeze
  STATE_ATTRIBUTES = %i[internship_state_id contract_state_id registration_state_id
                        report_state_id payment_state_id
                        reading_prof_id certificate_signed_by_internship_officer
                        certificate_signed_by_prof
                        certificate_state_id
                        certificate_to_prof].freeze
  REPORT_ATTRIBUTES = [:internship_report].freeze
  NOT_USED_ATTRIBUTES = %i[completed user_id].freeze
  WORK_DESCRIPTION_ATTRIBUTES = %i[operational_area
                                   orientation_id description title tasks].freeze
  NESTED_ATTRIBUTES = [{ programming_languages: [] }].freeze
  SUPERVISOR_ATTRIBUTES = %i[supervisor_email
                             supervisor_name].freeze

  REVIEW_ATTRIBUTES = %i[comment
                         recommend
                         working_hours
                         salary
                         living_costs
                         internship_rating_attributes
                         internship_rating_id
                         email_public].freeze

  # title (job title, usually not used, not part of active admin)
  # orientation_id (not used)

  private

  def internship_params
    params.require(:internship).permit(
      InternshipsController.permitted_params
    )
  end
end
