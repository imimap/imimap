# frozen_string_literal: true

require 'rails_helper'

describe 'header.internship is shown for factory users' do
  #(1..1000).each do
  context 'student users' do
    before :each do
      @user = create(:user)
      sign_in(@user)
      puts @user.email
    end
    it 'feature is on for test users' do
      visit root_path
      expect(page).to have_content t('header.internship')
    end
  end
#end
  context 'user with s05... addresses' do
    before :each do
      @user = create(:user, email: 's051234@htw-berlin.de')
      sign_in(@user)
    end
    it 'dont see the feature' do
      visit root_path
      expect(page).not_to have_content t('header.internship')
    end
  end
end
