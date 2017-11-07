# frozen_string_literal: true

require 'rails_helper'

describe "SignUp Process" do
  before :each do
    I18n.locale = :de
  end
  context "(not logged in)" do
    it 'verifies via ldap and creates a new user and student' do
      pending "implement with new login"
      visit root_path
      fill_in 'user_email', with: 's0123456'
      fill_in 'user_password', with: 'geheim'
      click_on I18n.t('devise.sessions.submit')
      # expect(LdapAuthentication.mode).to eq :test
      # save_and_open_page
      fail
    end
    context "with failing ldap authorization" do
      # before :each do
      #   LdapAuthentication.configure(mode: :test_fail)
      # end
      # after :each do
      #   LdapAuthentication.configure(mode: :test)
      # end

      it "shows error on ldap login", js: true  do
        pending("still failing intermittently - remove the js s* out of the registration process")
        fail
        visit root_path
        click_on I18n.t('devise.sessions.submit')
      #  page.save_screenshot 'poltergeist/ldap-failure-sign-in.png'

        expect(page).to have_content 'Please log in with your laboratory account'
        fill_in 'user_name', with: 's0123456'
        fill_in 'password_entry', with: 'geheim'
        click_on 'Verify'
        expect(LdapAuthentication.mode).to eq :test_fail
        page.save_screenshot 'poltergeist/ldap-failure.png'

        expect(page).to have_content  I18n.t('ldap.authorization_failed')

      end
    end
  end
end
