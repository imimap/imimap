# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'complete_internships/index', type: :view do
  before(:each) do
    assign(:complete_internships, [
             CompleteInternship.create!(
               semester: 'WS 2019/20',
               semester_of_study: 4,
               aep: false,
               passed: false
             ),
             CompleteInternship.create!(
               semester: 'SS 2019',
               semester_of_study: 5,
               aep: true,
               passed: false
             )
           ])
  end

  it 'renders a list of complete_internships' do
    render
    assert_select 'tr>td', text: 'WS 2019/20'.to_s, count: 1
    assert_select 'tr>td', text: 'SS 2019'.to_s, count: 1
    assert_select 'tr>td', text: 4.to_s, count: 1
    assert_select 'tr>td', text: 4.to_s, count: 1
    assert_select 'tr>td', text: true.to_s, count: 1
    assert_select 'tr>td', text: false.to_s, count: 3
  end
end
