require 'rails_helper'

describe "Student Login" do
  I18n.available_locales.each do | locale |
  context "in locale #{locale}" do
    before :each do
      I18n.locale = locale
    end
    context "with valid user credentials" do
      before :each do
        @user = create(:user)
      end

      it "should proceed to log in" do
        visit root_path
        fill_in "user_email",  :with => @user.email
        fill_in "user_password",  :with => @user.password
        click_on('Log in')

        expect(page).to have_content I18n.t('header.exchange')
      end
    end
 end
 end
 end
