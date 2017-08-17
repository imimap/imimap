require 'rails_helper'

describe "ActiveAdmin create Student" do
    before :each do
      @admin_user = create :admin_user
    # login_as(@admin_user, :scope => :admin_user)
      sign_in(@admin_user)
      I18n.locale = "en"
    end
    describe "pages" do
      it "index" do
      #  visit "admin/students"
        visit admin_students_path
        expect(I18n.locale).to eq :de
        # save_and_open_page
        expect(page).to have_content I18n.t("activerecord.models.student.other")
      #  click_button "New Student"
      #  expect(page).to have_content "New Student"
        # or: visit 'admin/students/new?locale=en'
      end
    end

end
