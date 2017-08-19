require 'rails_helper'

RSpec.describe "reads/new", type: :view do
  before(:each) do
    assign(:read, Read.new(
      :user_id => 1,
      :internship_id => 1
    ))
  end

  it "renders new read form" do
    render

    assert_select "form[action=?][method=?]", reads_path, "post" do

      assert_select "input#read_user_id[name=?]", "read[user_id]"

      assert_select "input#read_internship_id[name=?]", "read[internship_id]"
    end
  end
end
