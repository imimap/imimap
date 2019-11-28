# frozen_string_literal: true

require 'rails_helper'

describe 'Map Views' do
  context 'not logged in' do
    it 'redirects to login' do
      visit root_path
      expect(page).to have_content(t('welcome.login_with_hrz'))
    end
  end
  context 'user logged in' do
    before :each do
      @user = create(:user)
      sign_in(@user)
    end
    it 'map is shown' do
      visit root_path
      expect(page).to have_content('HTW Berlin')
    end
  end
end
