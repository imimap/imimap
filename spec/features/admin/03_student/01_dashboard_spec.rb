# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin Student / Dashboard' do
  context '(logged in)' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
    end
    it 'has Student Link' do
      visit admin_root_path
      expect(page).to have_content t('activerecord.models.student.other')
    end
    it 'Link works' do
      @internship = create(:internship)
      visit admin_root_path
      click_on t('activerecord.models.student.other')
      expect(current_path).to eq admin_students_path(locale: I18n.locale)
    end
  end
end
