class CompanyAddressesController < ApplicationController
  before_action :set_company_address, only: [:show, :edit, :update, :destroy]

  # GET /company_addresses
  def index
    @company_addresses = CompanyAddress.all
  end

  # GET /company_addresses/1
  def show
  end

  # GET /company_addresses/new
  def new
    @company_address = CompanyAddress.new
  end

  def new_address
    @company_address = CompanyAddress.new
    @company = Company.find(params[:company_id])
  end

  # GET /company_addresses/1/edit
  def edit
  end

  # POST /company_addresses
  def create
    @company_address = CompanyAddress.new(company_address_params)

    respond_to do |format|
      if @company_address.save
        format.html { redirect_to new_internship_path, notice: 'Company & its Address were successfully created.' }
        format.json { render json: @company_address, status: :created, location: @company_address }
      else
        render :new
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_addresses/1
  def update
    if @company_address.update(company_address_params)
      redirect_to @company_address, notice: 'Company address was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /company_addresses/1
  def destroy
    @company_address.destroy
    redirect_to company_addresses_url, notice: 'Company address was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_address
      @company_address = CompanyAddress.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_address_params
      params.require(:company_address).permit(:street, :zip, :city, :country, :phone, :company_id)
    end
end
