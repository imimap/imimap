
require 'rails_helper'

describe "ActiveAdmin Internship CRUD" do
  context "logged in" do
    before :each do
      @admin_user = create :admin_user
      login_as(@admin_user, :scope => :admin_user)
      I18n.locale = "de"
    end
    describe "show internship" do
      it "shows internship" do
        internship = create(:internship)
        visit admin_internship_path(internship)
        expect(page).to have_content internship.title
      end
    end
  end
  context "not logged in" do
    describe "show internship" do
      it "shows unauthenticated failure" do
        internship = create(:internship)
        visit admin_internship_path(internship)
        expect(page).to have_content I18n.t('devise.failure.admin_user.unauthenticated')
      end
    end
  end
end
