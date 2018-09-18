# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin Internship / Index' do
  context '(logged in)' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
      @internship = create(:internship)
    end
    it 'shows internships details headers' do
      visit admin_internships_path
      expect(page).to have_content t('activerecord.attributes.internship.student')
      expect(page).to have_content t('activerecord.attributes.internship.company_v2')
      expect(page).to have_content t('activerecord.attributes.internship.semester')
    end
    it 'shows internships details data' do
      visit admin_internships_path
      expect(page).to have_content @internship.student.last_name
      expect(page).to have_content @internship.student.first_name
      expect(page).to have_content @internship.company_v2.name
      expect(page).to have_content @internship.semester.name
    end
    it 'has link to Student' do
      visit admin_internships_path
      click_on @internship.student.name
      expect(current_path).to eq admin_student_path(id: @internship.student) # , locale: I18n.locale)
    end
    it 'has link to Internship' do
      visit admin_internships_path
      click_on t('active_admin.view')
      expect(current_path).to eq admin_internship_path(id: @internship, locale: I18n.locale)
    end
  end
end
