# frozen_string_literal: true

require 'rails_helper'

describe 'internship index - ' do
  context 'with role student' do
    before :each do
      @user = create(:student_user)
      sign_in(@user)
    end
    it 'doesnt see the link in the main menu' do
      visit root_path
      expect(page).not_to have_content(t('header.current_internships'),
                                       count: 2)
    end
    it 'cannot see the list of internships' do
      visit internships_path
      expect(page).to have_content('CanCan::AccessDenied')
    end
  end
end
