# frozen_string_literal: true

# Controller for CompanyAddresses
class CompanyAddressesController < ApplicationResourceController
  include CompanyAddressesHelper
  load_and_authorize_resource
  # before_action :set_company_address, only: %i[edit update destroy]
  before_action :set_company_id, only: %i[suggest_address]

  # def index
  #   @company_addresses = CompanyAddress.all
  # end

  def show
    company = Company.find(params[:company_id])
    @company_address = company.company_addresses.find(params[:id])
  end

  # def new
  #   @company_address = CompanyAddress.new
  # end

  def new_address
    @company_address = CompanyAddress.new
    @company = Company.find(params[:company_id])
    @internship = find_internship
  end

  def edit
    authorize! :edit, @company_address
  end

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

  # should be create
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
    # authorize! :update, @company_address
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

  # def set_company_address
  #   @company_address = CompanyAddress.find(params[:company_id])
  # end

  def update_target
    if @current_user.student
      @current_user.student.complete_internship
    else
      @company_address
    end
  end

  def set_internship_group
    # The accessible_by call cannot be used with a block 'can' definition.
    #   .accessible_by(current_ability, :edit)
    @internship = Internship.find_for(
      id: params[:company_address][:internship_id],
      action: :edit,
      ability: current_ability
    )

    #  @internship.company_address.build(company_address_params)
    @company_address = CompanyAddress.new(company_address_params)
    @company = Company.find(params[:company_id])
  end

  def set_company_id
    @company_id = params[:company_id]
  end
end
