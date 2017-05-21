require 'rails_helper'

describe "ActiveAdmin Student creation" do
  before :each do
    @admin_user = create :admin_user
    # The Setting / Usage of the locale is a quick fix, as the current routes
    # setup doesn't use locales for ActiveAdmin. See
    # https://github.com/activeadmin/activeadmin/wiki/Switching-locale
    # Tests should work independently of set locale.
    I18n.locale = "de"
  end
  describe "login" do
    it "logs in a user" do
      visit admin_root_path
      login_t = I18n.t('active_admin.devise.login.title')
      email_t = I18n.t('activerecord.attributes.admin_user.email')
      password_t =  'Passwort'
      signed_in_t = I18n.t('devise.sessions.admin_user.signed_in')
      fill_in email_t, with: @admin_user.email
      fill_in password_t, with: @admin_user.password
      click_button login_t

      expect(page).to have_content signed_in_t
    end
  end

end
