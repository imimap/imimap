# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Authorization student users' do
  before :each do
    @user = create(:user)
    sign_in(@user)
  end
  it 'have no access admin area' do
    visit admin_root_path
    # be on the student page
    expect(page).to have_content t('devise.failure.already_authenticated')
    expect(page).to have_content t('header.internship')
    # not the admin area
    expect(page).not_to have_content t('active_admin.dashboard')
    expect(page)
      .not_to have_content t('active_admin.dashboard_welcome.welcome')
  end
end
