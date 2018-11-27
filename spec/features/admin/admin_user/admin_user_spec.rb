# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Admin User' do
  context 'when logged in' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
    end
    describe 'pages' do
      it 'index' do
        visit admin_users_path
        one, two = @admin_user.email.split('@')
        expect(page).to have_content one
        expect(page).to have_content two
      end
    end

    # we check if changing the mail address of a user
    # without touching the password works
    describe 'controller' do
      it 'update' do
        @user = create(:user)
        visit admin_users_path(id: @user)
        click_on t('users.edit.edituser')
        expect(page).not_to have_content 'NoMethodError'
        expect(page).to have_content t('users.edit.edituser')
        old_email = @user.email
        fill_in t('activerecord.attributes.user.email'), with: 'testmail@htw-berlin.de'
        click_on t('users.update')
        expect(page).to have_content 'testmail@htw-berlin.de'
        expect(page).not_to have_content old_email
      end
    end
  end
end
