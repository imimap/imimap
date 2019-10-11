# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin User' do
  context 'logged in' do
    before :each do
      @admin = create :admin
      @user = create :user
      @prof = create :prof
      sign_in @admin
      I18n.locale = 'de'
    end
    it 'shows users' do
      visit admin_users_path
      [@admin, @user, @prof].each do |u|
        expect(page).to have_content u.email
      end
    end
    it 'shows single user' do
      visit admin_user_path(id: @prof.id)
      expect(page).to have_content @prof.email
    end
    it 'creates user' do
      visit new_admin_user_path
      expect(page).to have_content t('active_admin.new_model',
                                     model: User.model_name.human)
      # TBD write actual test
    end
    it 'edits user' do
      visit edit_admin_user_path(id: @prof.id)
      expect(page).to have_content t('active_admin.edit_model',
                                     model: User.model_name.human)
      # TBD write actual test
    end
  end
end
