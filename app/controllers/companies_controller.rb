# frozen_string_literal: true

# Companies Controller
class CompaniesController < ApplicationResourceController
  before_action :set_company, only: %i[show edit update destroy]
  before_action :new_company, only: %i[new]
  before_action :new_company_params, only: %i[create create_and_save]
  before_action :set_internship_id, only: %i[create update]

  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def show
    @internships = @company.internships
    respond_to do |format|
      format.html
    end
  end

  def new
    @company = Company.new
    if @current_user.student
      @internship = @current_user.student
                                 .complete_internship
                                 .internships
                                 .find(params[:internship_id])
    end
    respond_to do |format|
      format.html
    end
  end

  def edit
    @company = Company.find(params[:id])
    return unless @current_user.student

    @internship = @current_user.student
                               .complete_internship
                               .internships
                               .find(params[:internship_id])
  end

  def create
    respond_to do |format|
      if @company.save
        format.html do
          redirect_to new_address_path(@company.id,
                                       internship_id: @internship_id),
                      notice: 'Company was successfully created.'
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html do
          if @current_user.student
            redirect_to edit_company_address_path(
              Internship.find(@internship_id).company_address
            ), notice: 'Company was successfully updated.'
          else
            redirect_to @company, notice: 'Company was successfully updated.'
          end
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end

  def self.permitted_params
    %i[name website main_language industry number_employees comment
       excluded_from_search]
  end

  def company_params
    params.require(:company).permit(CompaniesController.permitted_params)
  end

  def suggest
    suggestion = params[:name].downcase
    @case = nil
    @company_suggestion = company_suggestion(suggestion)
  end

  private

  def set_internship_id
    @internship_id = params[:company][:internship_id]
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def new_company
    @company = Company.new
  end

  def new_company_params
    @company = Company.new(company_params)
  end

  def select_company; end

  # TBD: there seem to be no test cases for this!
  def company_suggestion(suggestion)
    # erste Runde, ungefaehres Matching
    first_search = '%' + suggestion + '%'
    results = Company.where('lower(name) LIKE ?', first_search)
    @case = if results.count.zero?
              3
            else
              1
            end
    if results.count > 4
      # zweite Runde, exaktes Matching
      results = Company.where('lower(name) LIKE ?', suggestion)
      @case = 1
      if results.count > 4
        @case = 2
        nil
      elsif results.count.zero?
        # das ist auch der too many case
        # testfaelle sind verdreht.
        @case = 2
        nil
      end
    end
    results.select do |c|
      UserCanSeeCompany.company_search(company_id: c.id, user: current_user)
    end
  end
end
