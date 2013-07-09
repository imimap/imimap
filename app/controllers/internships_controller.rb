class InternshipsController < ApplicationController
  respond_to :html, :json
  before_filter :get_programming_languages, :get_orientations, :only => [:edit, :update]
  before_filter :authorize
  before_filter :authorize_internship, :only => [:edit, :update, :destroy]
  # GET /internships
  # GET /internships.json
  def index
    @internships = Internship.includes(:company)
    @current_user = User.find(current_user.id)

    @companies = @internships.collect do |x| x.company end

    @countries = @companies.collect do |x| x.country end.uniq

    @semesters = Semester.where(:id =>(@internships.collect do |x| x.semester_id end.uniq)).map do |s| [s.semester, s.id] end

    @orientations = (Orientation.where(:id => @internships.collect do |x| x.orientation_id end)).uniq.map do |o| [o.name, o.id] end

    @living_costs_max = @internships.collect do |x| x.living_costs end.max
    @living_costs_max ||= 0

    @salary_max = @internships.collect do |x| x.salary end.max    
    @salary_max ||= 0

    @salary = 0
    @salary = params[:salary] if params[:salary].present?
    @living_costs = @living_costs_max
    @living_costs = params[:living_costs] if params[:living_costs].present?

    orientations = params[:orientation].collect{|s| s.to_i} if params[:orientation].present?
    semesters = params[:semester].collect{|s| s.to_i} if params[:semester].present?

    if params[:programming_language_ids].present?
      internships_ary = []
      languages = params[:programming_language_ids].collect{|s| s.to_i} if params[:programming_language_ids].present?
      programming_languages = ProgrammingLanguage.find(languages)
      programming_languages.each do |x|
        if internships_ary.empty?
          internships_ary = x.internships.collect do |s| s.id end
        else
          internships_ary = internships_ary & x.internships.collect do |s| s.id end
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

    #@internships = @internships.where('working_hours <= ?',params[:working_hours])
    @internships = @internships.where('living_costs <= ?',@living_costs.first) if params[:living_costs].present?
    #@internships = @internships.where('rating >= ?',params[:rating])
    @internships = @internships.where('salary >= ?',@salary.first) if params[:salary].present?

    @programming_languages = ProgrammingLanguage.order(:name).where(:id => (Internship.joins(:programming_languages).select(:programming_language_id).collect do |x| x.programming_language_id end).uniq).map do |p|
      [p.name, p.id]
    end

    @internships_size = @internships.size

    respond_with(@internships)
  end

  # GET /internships/1
  # GET /internships/1.json
  def show
    @internship = Internship.find(params[:id])
    @comment = UserComment.new
    @answer = Answer.new
    @favorite = Favorite.where(:internship_id => @internship.id, :user_id => current_user.id)[0]
    @user_comments = @internship.user_comments.order("created_at DESC")

    @pins = @internship.company.to_gmaps4rails do |company, marker |
      if company.website
        href =  if company.website.starts_with?'http' 
              company.website  
            else 
              "http://"+company.website 
             end
      end

      marker.infowindow ("<a href='/companies/#{company.id}' style='font-weight:bold'>#{company.name}</a><p>Industry: #{company.industry}</p><p>Employees: #{company.number_employees}</p><a href='#{href}' target='_blank'>#{company.website}</a>")

    end

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
    if @internship.update_attributes(params[:internship])
      flash[:notice] = 'Internship was successfully updated.'
    end
    respond_with(@internship)
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

private

    def authorize_internship
      internship = Internship.where(id: params[:id]).first
      if current_user.student && internship && internship.student_id != current_user.student.id
        redirect_to overview_index_path, notice: "You're not allowed to edit this internship"
      elsif internship.nil?
        redirect_to overview_index_path, notice: "You're not allowed to edit this internship"
      end
    end

end
