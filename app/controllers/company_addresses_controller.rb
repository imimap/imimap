# frozen_string_literal: true

# Controller for CompanyAddresses
class CompanyAddressesController < ApplicationResourceController
  before_action :set_company_address, only: %i[show edit update destroy]

  def index
    @company_addresses = CompanyAddress.all
  end

  def show; end

  def new
    @company_address = CompanyAddress.new
  end

  def new_address
    @company_address = CompanyAddress.new
    @company = Company.find(params[:company_id])
  end

  def edit; end

  def create
    @company_address = CompanyAddress.new(company_address_params)
    respond_to do |format|
      if @company_address.save
        format.html
        # format.html do
        #  redirect_to new_internship_path,
        #             notice: 'Company & its Address were successfully created.'
        # end
        redirect_to complete_internship_path(current_user
                                              .student.complete_internship)
      else
        render :new, notice: "Company address couldn't be created."
      end
    end
  end

  def update
    if @company_address.update(company_address_params)
      redirect_to @company_address,
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

  def create_and_save(internship_id)
    respond_to do |format|
      if @company_address.save
        # CodeReviewSS17 seems a bit too specific for the general create
        # case, but if Company#create isn't called from anywhere else,
        # why not. but if the company was specifically created for the
        # internship, it should be passed to the new internship.
        @internship = Internship.find(internship_id)
        @internship.update_attribute(company_address_id, @company_address.id)

        format.html do
          redirect_to new_address_path(@company.id),
                      notice: 'Company was successfully created.'
        end
      else
        format.html { render action: 'new' }
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
