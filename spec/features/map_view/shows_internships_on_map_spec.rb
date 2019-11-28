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
      @ws19 = ws19 = create(:ws2019)
      @ss19 = ss19 = create(:ss2019)
      @ca1 = ca1 = create(:company_address_for_edit)
      @ca2 = ca2 = create(:company_address_1)
      @internship1 = create(:internship_without_company_address,
                            semester: ws19, company_address: ca1)
      @internship2 = create(:internship_without_company_address,
                            semester: ss19, company_address: ca2)
    end
    it "map is shown for #{@ws19}" do
      visit root_path(semester_id: @ws19.id)
      # expect(@internship1.company_address.city).to eq @ca1.city
      expect(page).to have_content('HTW Berlin')
      expect(page.body).to have_content(@ca1.city)
      expect(page.body).not_to have_content(@ca2.city)
    end
    it "map is shown for #{@ss19}" do
      visit root_path(semester_id: @ss19.id)
      expect(page).to have_content('HTW Berlin')
      expect(page.body).not_to have_content(@ca1.city)
      expect(page.body).to have_content(@ca2.city)
    end
    it 'map is shown all semesters ' do
      visit root_path(semester_id: -1)
      expect(page).to have_content('HTW Berlin')
      expect(page.body).to have_content(@ca1.city)
      expect(page.body).to have_content(@ca2.city)
    end
  end
end
