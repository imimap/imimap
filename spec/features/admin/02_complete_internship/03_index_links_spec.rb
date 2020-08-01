# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin CompleteInternship / index links' do
  before :each do
    sign_in create(:admin_user)
    @student = create(:student)
    @complete_internship = create(:complete_internship, student: @student)
  end

  it 'has link to Student' do
    visit admin_complete_internships_path
    click_on @complete_internship.student.name
    expect(current_path).to eq admin_student_path(
      id: @complete_internship.student,
      locale: I18n.locale
    )
  end
  it 'has link to Internships' do
    visit admin_complete_internships_path
    click_on t('active_admin.view')
    expect(current_path).to eq admin_complete_internship_path(
      id: @complete_internship,
      locale: I18n.locale
    )
  end
end
