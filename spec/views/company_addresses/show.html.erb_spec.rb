require 'rails_helper'

RSpec.describe "company_addresses/show", type: :view do
  before(:each) do
    @company_address = assign(:company_address, CompanyAddress.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
