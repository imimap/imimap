require 'rails_helper'

RSpec.describe "reads/show", type: :view do
  before(:each) do
    @read = assign(:read, Read.create!(
      :user_id => 2,
      :internship_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
