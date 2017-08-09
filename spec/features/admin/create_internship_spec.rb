
require 'rails_helper'

describe "ActiveAdmin create Internship" do
    before :each do
      @admin_user = create :admin_user
    # login_as(@admin_user, :scope => :admin_user)
      sign_in(@admin_user)
      I18n.locale = "de"
    end
    describe "pages" do
      it "index" do
        visit "admin/internships"
        save_and_open_page
        expect(page).to have_content "Internships"
      #  click_button "New Internship"
      #  expect(page).to have_content "New Internship"
        # or: visit 'admin/internships/new?locale=en'
      end
    end

end
