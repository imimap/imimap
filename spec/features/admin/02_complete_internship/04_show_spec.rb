# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

describe 'ActiveAdmin CompleteInternship / show' do
  context 'logged in' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
    end
    it 'shows complete_internship' do
      student = create(:student)
      complete_internship = create(:complete_internship, student: student)
      visit admin_complete_internship_path(id: complete_internship)

      expect(page).to have_content student.name
      expect(page).to have_content complete_internship.semester.name
      expect(page).to have_content complete_internship.semester_of_study
    end
  end
end
