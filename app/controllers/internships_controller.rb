class InternshipsController < ApplicationController
  respond_to :html, :json
  before_action :get_programming_languages, :get_orientations, :only => [:new, :edit, :update]

  before_action :authorize_internship, :only => [:edit, :update, :destroy]
  # GET /internships
  # GET /internships.json

  include InternshipsHelper
  def index
    @internship_count = Internship.all.count
  end

  def new
    @internship = Internship.new
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
        format.html { render action: "new" }
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
    @favorite = Favorite.where(:internship_id => @internship.id, :user_id => current_user.id)[0]
    @company = @internship.company
    @other_internships = @company.internships.reject { |x| x.id == @internship.id }.reject{ |i| i.completed == false }

    @user_comments = @internship.user_comments.order("created_at DESC")


    respond_with(@internship)
  end


  # GET /internships/1/edit
  def edit
    @internship = Internship.find(params[:id])
    @company = @internship.company
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
      render :edit, notice: "Please fill in all fields"
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
  def internshipData
    if Internship.where(user_id: current_user.id).last.nil?
      render :noInternshipData
    else
      @internship = Internship.where(user_id: current_user.id).last
      redirect_to @internship
    end
  end


  private

  # this was defined but not used.
  def internship_params
    params.require(:internship).permit(:attachments_attributes, :living_costs, :orientation_id,
                     :salary, :working_hours, :programming_language_ids,
                     :internship_rating_id, :company_id, :user_id, :title,
                     :recommend, :email_public, :semester_id, :description,
                     :internship_report, :student_id, :start_date, :end_date,
                     :operational_area, :tasks, :internship_state_id,
                     :reading_prof_id, :payment_state_id, :registration_state_id,
                     :contract_state_id, :report_state_id, :certificate_state_id,
                     :certificate_signed_by_internship_officer,
                     :certificate_signed_by_prof, :certificate_to_prof, :comment,
                     :supervisor_email, :supervisor_name,
                     :internship_rating_attributes, :completed)

  end

  def authorize_internship
    internship = Internship.where(id: params[:id]).first
    if current_user.student && internship && internship.student_id != current_user.student.id
      redirect_to overview_index_path, notice: "You're not allowed to edit this internship"
    elsif internship.nil?
      redirect_to overview_index_path, notice: "You're not allowed to edit this internship"
    end
  end
end
