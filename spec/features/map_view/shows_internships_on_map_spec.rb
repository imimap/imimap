# frozen_string_literal: true

require 'rails_helper'

describe 'Map View' do
  context 'as user' do
    before :each do
      @user = create(:user)
      sign_in(@user)
    end
    it 'map is shown' do
      visit root_path
      expect(page).to have_content('HTW Berlin')
    end
  end
  context 'as admin' do
    before :each do
      @admin = create(:admin)
      sign_in(@admin)
    end
    it 'map is shown' do
      ws19 = create(:ws2019)
      ss19 = create(:ss2019)
      ca1 = create(:company_address_for_edit)
      ca2 = create(:company_address_1)
      internship1 = create(:internship, semester: ws19, company_address: ca1)
      internship2 = create(:internship, semester: ss19, company_address: ca2)
      visit root_path
      expect(page).to have_content('HTW Berlin')
      save_and_open_page
    end
  end
end
