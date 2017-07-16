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

      it "should log in" do
        visit root_path
        fill_in "email",  :with => @user.email
        fill_in "password",  :with => @user.password
        page.find('.signin-icon').click
        expect(page).to have_content I18n.t('header.exchange')
      end
    end
 end
 end
 end
