require 'rails_helper'

RSpec.describe "complete_internships/index", type: :view do
  before(:each) do
    assign(:complete_internships, [
      CompleteInternship.create!(
        :semester => "Semester",
        :semester_of_study => 2,
        :aep => false,
        :passed => false
      ),
      CompleteInternship.create!(
        :semester => "Semester",
        :semester_of_study => 2,
        :aep => false,
        :passed => false
      )
    ])
  end

  it "renders a list of complete_internships" do
    render
    assert_select "tr>td", :text => "Semester".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
