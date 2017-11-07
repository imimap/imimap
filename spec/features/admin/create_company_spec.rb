# frozen_string_literal: true

#
require 'rails_helper'

describe "ActiveAdmin create Company" do
    before :each do
      @admin_user = create :admin_user
    # login_as(@admin_user, :scope => :admin_user)
      sign_in(@admin_user)
      I18n.locale = "en"
    end
    describe "pages" do
      it "index" do
      #  visit "admin/companies"
        visit admin_companies_path
        expect(I18n.locale).to eq :de
        # save_and_open_page
        expect(page).to have_content I18n.t("activerecord.models.company.other")
      #  click_button "New Company"
      #  expect(page).to have_content "New Company"
        # or: visit 'admin/companies/new?locale=en'
      end
    end

end
