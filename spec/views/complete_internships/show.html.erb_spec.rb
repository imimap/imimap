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
    expect(rendered).to match(/Auswertung von Erfahrungen am Praxisplatz/)

    expect(rendered).to match(/B20/)
    expect(rendered).to match(/B20.1/)
    expect(rendered).to match(/B20.2/)
    # expect(rendered).to match(/passed/)
  end
end
