# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin index reading_profs' do
  before :each do
    sign_in create(:admin_user)
    @profs = [create(:reading_prof),
              create(:reading_prof1),
              create(:reading_prof2),
              create(:reading_prof3)]
  end
  it 'shows internships details headers' do
    visit admin_reading_profs_path
    @profs.each do |prof|
      expect(page).to have_content prof.name
    end
  end
  it 'shows single prof ' do
    prof = @profs[0]
    visit admin_reading_prof_path(locale: 'de', id: prof.id)
    expect(page).to have_content(prof.name)
  end
end
