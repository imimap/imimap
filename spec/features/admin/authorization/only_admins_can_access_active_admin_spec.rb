# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Authorization' do
  context 'student users' do
    before :each do
      @user = create(:user)
      sign_in(@user)
    end
    it 'have no access admin area' do
      visit admin_root_path
      expect(page).to have_content t('devise.failure.already_authenticated')
    end
  end

  context 'profs' do
    before :each do
      @prof = create(:prof)
      sign_in(@prof)
    end
    it 'have no access admin area' do
      visit admin_root_path
      expect(page).to have_content t('devise.failure.already_authenticated')
    end
  end

  context 'admins' do
    before :each do
      @admin = create(:admin)
      sign_in(@admin)
    end
    it 'have no access admin area' do
      visit admin_root_path
      expect(page).to have_content t('active_admin.dashboard')
    end
  end
end
