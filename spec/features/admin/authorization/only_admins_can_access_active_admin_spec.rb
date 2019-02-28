# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Authorization' do
  before :each do
    @admin = create(:admin)
    sign_in(@admin)
  end
  it 'have access admin area' do
    visit admin_root_path
    expect(page).to have_content t('active_admin.dashboard')
    expect(page).to have_content t('active_admin.dashboard_welcome.welcome')
  end
end
