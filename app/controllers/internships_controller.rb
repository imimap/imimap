class InternshipsController < ApplicationController
  respond_to :html, :json
  before_filter :get_programming_languages, :get_orientations, :only => [:new, :edit, :update]
  before_filter :authorize, :redirect_PV
  before_filter :authorize_internship, :only => [:edit, :update, :destroy]
  # GET /internships
  # GET /internships.json
  def index
    @internships = Internship.includes(:company, :semester, :orientation, :programming_languages).where(completed: true).order("internships.created_at DESC")

    @current_user = User.find(current_user.id)

    @companies = @internships.collect(&:company)

    @countries = @companies.collect(&:country)

    @semesters = @internships.map(&:semester).uniq.map{ |s| [s.name, s.id] }

    @orientations = @internships.collect(&:orientation).compact.uniq.collect { |o| [o.name, o.id] }

    @living_costs_max = @internships.collect(&:living_costs).max
    @living_costs_max ||= 0

    @salary_max = @internships.collect(&:salary).max
    @salary_max ||= 0

    @salary = 0
    @salary = params[:salary] if params[:salary].present?
    @living_costs = @living_costs_max
    @living_costs = params[:living_costs] if params[:living_costs].present?

    orientations = params[:orientation].collect(&:to_i) if params[:orientation]
    semesters = params[:semester].collect(&:to_i) if params[:semester]

    if params[:programming_language_ids].present?
      internships_ary = []
      languages = params[:programming_language_ids].collect{|s| s.to_i} if params[:programming_language_ids].present?
      programming_languages = ProgrammingLanguage.find(languages)
      programming_languages.each do |x|
        if internships_ary.empty?
          internships_ary = x.internships.collect(&:id)
        else
          internships_ary = internships_ary & x.internships.collect(&:id)
        end
      end
      @internships = @internships.where(:id => internships_ary)
    end

    @internships = @internships.where(:companies => {:country => params[:country]}) if params[:country].present?
    @internships = @internships.where(:orientation_id => orientations) if orientations.present?
    @internships = @internships.where(:semester_id => semesters) if semesters.present?

    @country_choices = params[:country] if params[:country].present?
    @semester_choices = params[:semester] if params[:semester].present?
    @orientation_choices = params[:orientation] if params[:orientation].present?
    @language_choices = params[:programming_language_ids] if params[:programming_language_ids].present?

    @internships = @internships.where('living_costs <= ?',@living_costs.first) if params[:living_costs].present?
    @internships = @internships.where('salary >= ?',@salary.first) if params[:salary].present?

    @programming_languages = ProgrammingLanguage.order(:name).where(:id => (Internship.joins(:programming_languages).select(:programming_language_id).collect do |x| x.programming_language_id end).uniq).map do |p|
      [p.name, p.id]
    end

    @internships_size = @internships.size

    respond_with(@internships)
  end

  def new
    @internship = Internship.new
    @company_last = Company.last
  end

  def create
    @internship = Internship.new(params[:internship])
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
    attributes = params[:internship]
    attributes.delete(:company_id)
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

  def internship_params
    params.require(:internship).permit(:title, :start_date, :end_date, :operational_area, :tasks, 
      :programming_language_ids, :orientation_id, :salary, :working_hours, :living_costs, :supervisor_name, :supervisor_email, 
      :internship_report, :recommend, :semester_id, :company_id)
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