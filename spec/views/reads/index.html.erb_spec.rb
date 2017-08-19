require 'rails_helper'

RSpec.describe "reads/index", type: :view do
  before(:each) do
    assign(:reads, [
      Read.create!(
        :user_id => 2,
        :internship_id => 3
      ),
      Read.create!(
        :user_id => 2,
        :internship_id => 3
      )
    ])
  end

  it "renders a list of reads" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
