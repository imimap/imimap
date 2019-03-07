# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin CompleteInternship / Dashboard' do
  context '(logged in)' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
    end
    it 'has Internship Link' do
      visit admin_root_path
      expect(page)
        .to have_content t('activerecord.models.complete_internship.other')
    end
    it 'Internship Link works' do
      @internship = create(:internship)
      visit admin_root_path
      click_on t('activerecord.models.complete_internship.other')
      expect(current_path)
        .to eq admin_complete_internships_path(locale: I18n.locale)
    end
  end
end
