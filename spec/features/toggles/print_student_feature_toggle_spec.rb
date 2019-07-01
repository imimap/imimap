# frozen_string_literal: true

require 'rails_helper'

describe 'complete_internships.checklist.print_form
                                    is shown for factory users' do
  # (1..1000).each do
  context 'student users' do
    before :each do
      @user = create(:user)
      sign_in(@user)
    end
    it 'feature is on for test users' do
      create(:semester)
      visit my_internship_path
      click_link(t('internships.createYourInternship'))
      click_on t('save')
      click_on t('complete_internships.new_tp0')
      click_on t('save')
      expect(page).to have_content t(
        'complete_internships.checklist.print_form'
      )
    end
  end
  # end
  context 'user with s05... addresses' do
    before :each do
      @user = create(:user_for_s05)
      sign_in(@user)
    end
    it 'dont see the feature' do
      create(:semester)
      visit my_internship_path
      click_link(t('internships.createYourInternship'))
      click_on t('save')
      click_on t('complete_internships.new_tp0')
      click_on t('save')
      expect(page).not_to have_content t(
        'complete_internships.checklist.print_form'
      )
    end
  end
end
