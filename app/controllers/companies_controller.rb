# frozen_string_literal: true

# Companies Controller
class CompaniesController < ApplicationResourceController
  before_action :set_company, only: %i[show edit update destroy]
  before_action :new_company, only: %i[new]
  before_action :new_company_params, only: %i[create create_and_save]

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
    # byebug
    respond_to do |format|
      if @company.save
        format.html do
          redirect_to new_address_path(@company.id,
                                       internship_id:
                                         params[:company][:internship_id]),
                      notice: 'Company was successfully created.'
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    # byebug
    respond_to do |format|
      if @company.update(company_params)
        format.html do
          if @current_user.student
            redirect_to edit_company_address_path(
              Internship.find(params[:company][:internship_id]).company_address
            ),
                        notice: 'Company was successfully updated.'
          else
            redirect_to @company,
                        notice: 'Company was successfully updated.'
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
    suggestion = '%' + params[:name].downcase + '%'
    @company_suggestion = Company.where('lower(name) LIKE ?', suggestion)
  end

  private

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
end
