
require 'rails_helper'

describe "ActiveAdmin Admin User" do
  context "when logged in" do
    before :each do
      @admin_user = create :admin_user
      login_as(@admin_user, :scope => :admin_user)
      I18n.locale = "de"
    end
    describe "pages" do
      it "index" do
        visit admin_user_path(@admin_user)
        expect(page).to have_content @admin_user.name
      end
    end
  end
end
