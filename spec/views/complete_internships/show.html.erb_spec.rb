# frozen_string_literal: true

require 'rails_helper'
require_relative './mock_path_helper.rb'

RSpec.describe 'complete_internships/show', type: :view do
  before(:each) do
    @complete_internship = assign(:complete_internship,
                                  create(:complete_internship))

    mockpath
  end

  it 'renders attributes in table' do
    render
    # expect(rendered).to match(/Semester/)
    expect(rendered).to match(/4/)

    expect(rendered).to have_content(
      t('complete_internships.aep.number')
    )
    expect(rendered).to have_content(
      t('complete_internships.parcial_internships.number')
    )
    expect(rendered).to have_content(
      t('complete_internships.ci.number')
    )

    expect(rendered).to have_content(
      t('complete_internships.aep.name')
    )
    expect(rendered).to have_content(
      t('complete_internships.parcial_internships.name')
    )
    expect(rendered).to have_content(
      t('complete_internships.ci.name')
    )
  end
end
