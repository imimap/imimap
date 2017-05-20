require 'rails_helper'

describe "Start Page" do
  before :each do
    I18n.locale = :de
  end
  it "shows the Forgot Password Link on the root page" do
    visit root_path
    expect(page).to have_content I18n.t('active_admin.devise.reset_password.title')
  end
end
