# frozen_string_literal: true

# Controller for CompanyAddresses
class CompanyAddressesController < ApplicationResourceController
  include CompanyAddressesHelper
  load_and_authorize_resource
  #before_action :set_company_address, only: %i[edit update destroy]

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
    @company_address_suggestion = CompanyAddress.where('company_id = ?',
                                                       params[:company_id])
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
      if @current_user.student
        redirect_to @current_user.student.complete_internship,
                    notice: 'Company address was successfully updated.'
      else
        redirect_to @company_address,
                    notice: 'Company address was successfully updated.'
      end
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

  def create_and_save
    @company_address = CompanyAddress.new(company_address_params)
    @company = Company.find(params[:company_id])
    @internship = find_internship_with_company_address
    respond_to do |format|
      if @company_address.save
        # CodeReviewSS17 seems a bit too specific for the general create
        # case, but if Company#create isn't called from anywhere else,
        # why not. but if the company was specifically created for the
        # internship, it should be passed to the new internship.
        @internship = find_internship_with_company_address
        @internship.update_attribute(:company_address_id, @company_address.id)
        redirect_to_ci(format)
      else
        format.html { render action: 'new_address' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company_address
    @company_address = current_user
                       .accessible_company_addresses
                       .find(params[:id])
    # @company_address = CompanyAddress.find(params[:id])
  end
end
