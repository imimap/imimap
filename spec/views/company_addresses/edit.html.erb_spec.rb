require 'rails_helper'

RSpec.describe "company_addresses/edit", type: :view do
  before(:each) do
    @company_address = assign(:company_address, CompanyAddress.create!())
  end

  it "renders the edit company_address form" do
    render

    assert_select "form[action=?][method=?]", company_address_path(@company_address), "post" do
    end
  end
end
