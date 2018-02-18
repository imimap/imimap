module InternshipsHelper

  def define_search_stuff
    @internships = Internship.includes(:company, :semester, :orientation, :programming_languages).where(completed: true).order("internships.created_at DESC")

    @current_user = User.find(current_user.id)

    #@state = RegistrationState.first

    #@current_intern = Internship.find(params[:id])

    #@current_internship = Internship.where(user_id: current_user).last

    @companies = @internships.collect(&:company)

    @countries = @companies.collect(&:country)

    @semesters = @internships.map(&:semester).uniq.map{ |s| [s.name, s.id] }

    @orientations = @internships.collect(&:orientation).compact.uniq.collect { |o| [o.name, o.id] }

    @living_costs_max = @internships.collect(&:living_costs).compact.max
    @living_costs_max ||= 0

    @salary_max = @internships.collect(&:salary).compact.max
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
end
