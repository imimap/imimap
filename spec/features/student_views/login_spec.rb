# frozen_string_literal: true

require 'rails_helper'

describe 'Student Login' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'with valid user credentials' do
        before :each do
          @user = create(:user)
        end

        it 'should proceed to log in and back to original page' do
          visit internships_path
          fill_in 'user_email', with: @user.email
          fill_in 'user_password', with: @user.password
          click_on('Log in')
          expect(page).to have_content I18n.t('devise.sessions.signed_in')
        end
      end
    end
  end
end
