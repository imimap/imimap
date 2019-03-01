# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'complete_internships/new', type: :view do
  before(:each) do
    assign(:complete_internship, create(:complete_internship))
  end

  it 'renders new complete_internship form' do
    render

    # assert_select 'form[action=?][method=?]',
    #    #          complete_internships_path, 'post' do
    #  assert_select 'input[name=?]', 'complete_internship[semester]'
    #
    #  assert_select 'input[name=?]', 'complete_internship[semester_of_study]'
    #
    #  assert_select 'input[name=?]', 'complete_internship[aep]'
    #
    #  assert_select 'input[name=?]', 'complete_internship[passed]'
    # end
  end
end
