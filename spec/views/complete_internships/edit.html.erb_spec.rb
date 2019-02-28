# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'complete_internships/edit', type: :view do
  before(:each) do
    @complete_internship = assign(:complete_internship, CompleteInternship.create!(
                                                          semester: 'MyString',
                                                          semester_of_study: 1,
                                                          aep: false,
                                                          passed: false
                                                        ))
  end

  it 'renders the edit complete_internship form' do
    render

    assert_select 'form[action=?][method=?]', complete_internship_path(@complete_internship), 'post' do
      assert_select 'input[name=?]', 'complete_internship[semester]'

      assert_select 'input[name=?]', 'complete_internship[semester_of_study]'

      assert_select 'input[name=?]', 'complete_internship[aep]'

      assert_select 'input[name=?]', 'complete_internship[passed]'
    end
  end
end
