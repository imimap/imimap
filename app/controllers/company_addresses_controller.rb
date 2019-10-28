# frozen_string_literal: true

# Controller for CompanyAddresses
class CompanyAddressesController < ApplicationResourceController
  include CompanyAddressesHelper
  load_and_authorize_resource
  # before_action :set_company_address, only: %i[edit update destroy]
  before_action :set_company_id, only: %i[suggest_address]

  def index
    @company_addresses = CompanyAddress.all
  end

  def show
    company = Company.find(params[:company_id])
    @company_address = company.company_addresses.find(params[:id])
  end

  def new
    @company_address = CompanyAddress.new
  end

  def new_address
    @company_address = CompanyAddress.new
    @company = Company.find(params[:company_id])
    @internship = find_internship
  end

  def edit; end

  def suggest_address
    ok = UserCanSeeCompany.company_suggest(company_id: @company_id,
                                           user: current_user)
    if ok
      @company_address_suggestion = CompanyAddress.where('company_id = ?',
                                                         @company_id)
    else
      render 'companies/limit_exceeded'
    end
  end

  def create
    @company_address = CompanyAddress.new(company_address_params)
    respond_to do |format|
      if @company_address.save
        redirect_to_ci(format)
      else
        format.html { render action: 'new', notice: 'Address creation failed.' }
      end
    end
  end

  # CodeReview: how do create and create_and_save differ? is create needed?
  def create_and_save
    set_internship_group
    respond_to do |format|
      if @company_address.save
        @internship.update_attribute(:company_address_id, @company_address.id)
        redirect_to_ci(format)
      else
        format.html { render action: 'new_address' }
      end
    end
  end

  def save_address
    # @company_address = CompanyAddress.find(params[:id])
    @internship = find_internship
    @internship.update_attribute(:company_address_id, params[:id])

    redirect_to complete_internship_path(
      @current_user.student.complete_internship
    ), notice: 'Company Address was successfully saved.'
  end

  def update
    if @company_address.update(company_address_params)
      redirect_to update_target,
                  notice: 'Company address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @company_address.destroy
    redirect_to company_addresses_url,
                notice: 'Company address was successfully destroyed.'
  end

  def company_address_params
    params.require(:company_address)
          .permit(CompanyAddressesController.permitted_params)
  end

  def self.permitted_params
    %i[street zip city country phone company_id fax latitude longitude]
  end

  private

  def update_target
    if @current_user.student
      @current_user.student.complete_internship
    else
      @company_address
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_company_address
    @company_address = current_user
                       .accessible_company_addresses
                       .find(params[:id])
    # @company_address = CompanyAddress.find(params[:id])
  end

  # CodeReview: this needs to be refactored/rethought.
  # CompanyAddresses are always created in the context of internships.
  # the internship should be independend of the logged in user,
  # to enable admins to use this functionality as well.
  def set_internship_group
    @company_address = CompanyAddress.new(company_address_params)
    @company = Company.find(params[:company_id])
    @internship = Internship
                  .accessible_by(current_ability, :edit)
                  .find(params[:company_address][:internship_id])
  end

  def set_company_id
    @company_id = params[:company_id]
  end
end
