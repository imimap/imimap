require 'rails_helper'

RSpec.describe "reads/edit", type: :view do
  before(:each) do
    @read = assign(:read, Read.create!(
      :user_id => 1,
      :internship_id => 1
    ))
  end

  it "renders the edit read form" do
    render

    assert_select "form[action=?][method=?]", read_path(@read), "post" do

      assert_select "input#read_user_id[name=?]", "read[user_id]"

      assert_select "input#read_internship_id[name=?]", "read[internship_id]"
    end
  end
end
