# frozen_string_literal: true

# Companies Controller
class CompaniesController < ApplicationResourceController
  def index
    @companies = Company.all
    # TBD ST
    # @companies =
    #  Company.order(:name).where("name like ?", "%#{params[:term]}%")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def show
    @company = Company.find(params[:id])

    @internships = @company.internships

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    respond_to do |format|
      if @company.save
        # CodeReviewSS17 seems a bit too specific for the general create
        # case, but if Company#create isn't called from anywhere else,
        # why not. but if the company was specifically created for the
        # internship, it should be passed to the new internship.
        format.html do
          redirect_to new_address_path(@company.id),
                      notice: 'Company was successfully created.'
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(company_params)
        format.html do
          redirect_to @company,
                      notice: 'Company was successfully updated.'
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @company = Company.find(params[:id])
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

  private

  def select_company
    current_user
    @company = Company.new
  end
end
