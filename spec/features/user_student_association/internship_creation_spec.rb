# frozen_string_literal: true

require 'rails_helper'

describe 'Internship creation and editing' do
  context 'first time - no user present' do
    before :each do
    end
    it 'user is created' do
      expect(User.count).to eq 0
      expect do
        visit root_path
        fill_in 'user_email', with: 's054321@htw-berlin.de'
        fill_in 'user_password', with: 'geheim'
        click_on I18n.t('devise.sessions.submit')
        expect(page).to have_content t('devise.sessions.signed_in')
      end.to change{User.count}.by(1)
    end
    it 'created user is associated with existing student object'
    it 'student object is created if not present'
  end

  context 'second time - user already present' do
    before :each do
    end
    it 'logs in and student info can be shown'
  end
end
