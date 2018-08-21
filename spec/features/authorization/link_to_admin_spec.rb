# frozen_string_literal: true

require 'rails_helper'

# Admin Link in main nav.
describe "ActiveAdmin Link" do
  context 'non admin roles' do
    before :each do
      @user = create(:user)
      sign_in(@user)
    end
    User::ROLES.reject{|r| r == :admin}.each do | role |
      it 'dont see link' do
        @user.role = role
        visit root_path
        expect(page).not_to have_content t('header.admin')
      end
    end
  end

  context 'admin role' do
    before :each do
      @user = create(:admin)
      sign_in(@user)
    end
    it 'see link' do
      visit root_path
      expect(page).to have_content t('header.admin')
    expect(page).to have_content t('header.admin')
    end
    it 'link leads to admin area' do
      visit root_path
      click_on t('header.admin')
      expect(page).to have_content t('active_admin.dashboard')
    end
  end
end
