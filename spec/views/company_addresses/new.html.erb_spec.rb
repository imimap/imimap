require 'rails_helper'

RSpec.describe "company_addresses/new", type: :view do
  before(:each) do
    assign(:company_address, CompanyAddress.new())
  end

  it "renders new company_address form" do
    render

    assert_select "form[action=?][method=?]", company_addresses_path, "post" do
    end
  end
end
