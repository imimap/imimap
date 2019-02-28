# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'complete_internships/show', type: :view do
  before(:each) do
    @complete_internship = assign(:complete_internship,
                                  create(:complete_internship))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Semester/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
