# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Authorization role prof' do
  before :each do
    @prof = create(:prof)
    sign_in(@prof)
  end
  it 'have no access admin area' do
    visit admin_root_path
    # be on the login page
    expect(page).to have_content t('welcome.login_with_hrz')
    # not the admin area
    expect(page)
      .not_to have_content t('active_admin.dashboard_welcome.welcome')
  end
end
