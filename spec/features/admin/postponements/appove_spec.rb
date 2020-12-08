# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Postponement Appoval' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
    @postponement = create(:postponement_unapproved)
    @postponement.student = create(:student)
    @postponement.save!
  end
  describe 'postponement' do
    it '#show has approval button' do
      visit admin_postponement_path(id: @postponement.id)
      expect(page).to have_content @postponement.student.first_name
      expect(page).to have_content @postponement.student.last_name
      expect(page).to have_button(t('postponements.approve'))
    end
    it '#show approves postponement' do
      visit admin_postponement_path(id: @postponement.id)
      click_button t('postponements.approve')
      expect(page).to have_content @postponement.student.first_name
      expect(page).to have_content @postponement.student.last_name
      expect(page).not_to have_button(t('postponements.approve'))
    end
    it '#index has appoval button' do
      visit admin_postponements_path
      expect(page).to have_content @postponement.student.first_name
      expect(page).to have_content @postponement.student.last_name
      expect(page).to have_link(t('postponements.approve'))
    end
    it '#index approves postponement' do
      visit admin_postponements_path
      click_link t('postponements.approve')
      expect(page).to have_content @postponement.student.first_name
      expect(page).to have_content @postponement.student.last_name
      expect(page).to have_content @postponement.approved_by
    end
  end
end
