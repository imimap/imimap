# frozen_string_literal: true

require 'rails_helper'
require_relative './mock_path_helper.rb'

RSpec.describe 'complete_internships/index', type: :view do
  before(:each) do
    mockpath
    # all instance variables used in the view need to be assigned
    # manually....
    s1 = create(:ss2019)
    s2 = create(:ws2019)
    assign(:semester, s1)
    assign(:complete_internships, [
             create(:complete_internship,
                    semester: s2,
                    semester_of_study: 4),
             create(:complete_internship,
                    semester: s1,
                    semester_of_study: 5, aep: false)

           ])
    assign(:semester_options, semester_select_options)
  end

  it 'renders a list of complete_internships' do
    render
    # expect(rendered).to eq "XXX"
    assert_select 'tr>td', text: 'WS 19/20'.to_s, count: 1
    assert_select 'tr>td', text: 'SS 19'.to_s, count: 1
    assert_select 'tr>td', text: 4.to_s, count: 1
    assert_select 'tr>td', text: 5.to_s, count: 1
    assert_select 'tr>td', text: 'bestanden', count: 1
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
