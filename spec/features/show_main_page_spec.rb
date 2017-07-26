require 'rails_helper'

describe "Start Page" do
  before :each do
    I18n.locale = :de
  end
  # we do not show forgot password link anymore
  # it "shows the Forgot Password Link on the root page" do
  #   visit root_path
  #   expect(page).to have_content I18n.t('activerecord.attributes.user.password')
  # end
end
