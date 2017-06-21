require 'rails_helper'

describe "internship/show.html.erb" do
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
        expect(page).to have_content internship.weekCount
        expect(page).to have_content internship.weekValidation
      end
    end
  end
end