# frozen_string_literal: true

require 'rails_helper'
require_relative './mock_path_helper.rb'

RSpec.describe 'complete_internships/index', type: :view do
  before(:each) do
    mockpath
    assign(:complete_internships, [
             create(:complete_internship,
                    semester: build(:ws2019),
                    semester_of_study: 4),
             create(:complete_internship,
                    semester: build(:ss2019),
                    semester_of_study: 5, aep: false)

           ])
  end

  it 'renders a list of complete_internships' do
    render
    # expect(rendered).to eq "XXX"
    assert_select 'tr>td', text: 'WS 19/20'.to_s, count: 1
    assert_select 'tr>td', text: 'SS 19'.to_s, count: 1
    assert_select 'tr>td', text: 4.to_s, count: 1
    assert_select 'tr>td', text: 5.to_s, count: 1
    assert_select 'tr>td', text: true.to_s, count: 1
    assert_select 'tr>td', text: false.to_s, count: 3
  end
end
