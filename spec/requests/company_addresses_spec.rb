require 'rails_helper'

RSpec.describe "CompanyAddresses", type: :request do
  describe "GET /company_addresses" do
    it "works! (now write some real specs)" do
      get company_addresses_path
      expect(response).to have_http_status(200)
    end
  end
end
