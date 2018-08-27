require 'rails_helper'

RSpec.describe "company_addresses/index", type: :view do
  before(:each) do
    assign(:company_addresses, [
      CompanyAddress.create!(),
      CompanyAddress.create!()
    ])
  end

  it "renders a list of company_addresses" do
    render
  end
end
