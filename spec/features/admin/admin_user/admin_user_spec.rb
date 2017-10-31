
require 'rails_helper'

describe "ActiveAdmin Admin User" do
  context "when logged in" do
    before :each do
      @admin_user = create :admin_user
      sign_in@admin_user
      I18n.locale = "de"
    end
    describe "pages" do
      it "index" do
        visit admin_users_path
        # save_and_open_page
        expect(page).to have_content @admin_user.email

        # put some of new translations
        # expect(page).to have_content I18n.t('activerecord.models.admin_user.other')
      end
    end
  end
end
