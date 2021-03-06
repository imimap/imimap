# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin index internship' do
  before :each do
    sign_in create(:admin_user)
    @internship = create(:internship)
  end
  it 'shows internships details headers' do
    visit admin_internships_path
    %w[student company_v2 semester].each do |field_name|
      expect(page)
        .to have_content t("activerecord.attributes.internship.#{field_name}")
    end
  end
  it 'shows internships details data' do
    visit admin_internships_path
    expect(page).to have_content @internship.student.last_name
    expect(page).to have_content @internship.student.first_name
    expect(page).to have_content @internship.company_v2.name
    expect(page).to have_content @internship.semester.name
  end
end
