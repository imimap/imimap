# frozen_string_literal: true

#
require 'rails_helper'

describe "ActiveAdmin Admin User" do
  context "when logged in" do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = "de"
    end
    describe "pages" do
      it "index" do
        visit admin_companies_path
        expect(page).to have_content Company.model_name.human
      end
    end
  end
end
