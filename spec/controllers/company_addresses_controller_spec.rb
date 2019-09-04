require 'rails_helper'

RSpec.describe CompanyAddressesController, type: :controller do
  render_views

  before :each do
    @current_user = login_as_admin
  end

  let(:valid_session) { {} }
  let(:valid_attributes) { build(:company_address).attributes }
end
