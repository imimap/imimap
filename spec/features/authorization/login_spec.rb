# frozen_string_literal: true

require 'rails_helper'
describe 'login on page' do
  it 'logs the user in' do
    @user = create(:user)
    login_via_interface_with(@user)
    expect(page).to have_content t('.devise.sessions.signed_in')
  end
end
