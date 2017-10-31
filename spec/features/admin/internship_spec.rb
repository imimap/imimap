require 'rails_helper'

describe "ActiveAdmin Internship CRUD" do
  context "logged in" do
    before :each do
      @admin_user = create :admin_user
      sign_in@admin_user
      I18n.locale = "de"
    end
    describe "show internship" do
      it "shows internship" do
        internship = create(:internship)
        visit admin_internship_path(internship)
      #  save_and_open_page
      #  expect(page).to have_content internship.end_date
      #  expect(page).to have_content internship.operational_area
      #  expect(page).to have_content internship.tasks
      #  expect(page).to have_content internship.supervisor_name
      #  expect(page).to have_content internship.supervisor_email
      #  expect(page).to have_content internship.comment
        expect(page).to have_content I18n.t("activerecord.attributes.internship.start_date")
        expect(page).to have_content I18n.t("activerecord.attributes.internship.end_date")
        expect(page).to have_content I18n.t("activerecord.attributes.internship.tasks")
        expect(page).to have_content I18n.t("activerecord.attributes.internship.supervisor_email")
        expect(page).to have_content I18n.t("activerecord.attributes.internship.supervisor_name")
        expect(page).to have_content I18n.t("activerecord.attributes.internship.comment")
      end
    end
  end
  context "not logged in" do
    describe "show internship" do
      it "shows unauthenticated failure" do
        I18n.locale = "de"
        expected_text = I18n.t('devise.failure.admin_user.unauthenticated')
        internship = create(:internship)
        visit admin_internship_path(internship)

        # need to add translation
        # expect(page).to have_content expected_text
      end
    end
  end
end
