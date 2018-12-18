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
        # visit admin_user_path(id: @user)
        # click_on t('active_admin.edit_model',model: User.model_name.human)
        visit edit_admin_user_path(id: @user)
        expect(page).not_to have_content 'NoMethodError'
        # save_and_open_page # um zu sehen was man sieht...
        # das funktioniert nicht weil es ein button ist:
        # expect(page).to
        # have_content t('helpers.submit.update', model: User.model_name.human)
        old_email = @user.email
        # nb: there is no translation yet for User.human_attribute_name(:email)
        fill_in User.human_attribute_name(:email),
                with: 'testmail@htw-berlin.de'
        click_on t('helpers.submit.update', model: User.model_name.human)
        expect(page).to have_content 'testmail@htw-berlin.de'
        expect(page).not_to have_content old_email
      end
    end
  end
end
