# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin CompleteInternship / index ' do
  before :each do
    sign_in create(:admin_user)
    @student = create(:student)
    @complete_internship = create(:complete_internship, student: @student)
    @internship = create(:internship, complete_internship: @complete_internship)
  end
  it 'shows student name' do
    visit admin_complete_internships_path
    expect(page).to have_content @student.name
  end
  it 'shows complete_internship details headers' do
    visit admin_complete_internships_path
    %w[aep passed semester semester_of_study].each do |field_name|
      expect(page)
        .to have_content(
          t("activerecord.attributes.complete_internship.#{field_name}")
        )
    end
  end
  it 'shows semester' do
    visit admin_complete_internships_path
    expect(page).to have_content @complete_internship.semester.name
  end
end
