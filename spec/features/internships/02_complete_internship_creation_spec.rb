# frozen_string_literal: true

require 'rails_helper'

describe 'Students can create their Internship information ' do
  context 'step01: create complete internship and internship' do
    before :each do
      @user = create(:student_user_wo_internship)
      sign_in(@user)
    end
    it 'internship creation' do
      visit root_path
      click_on t('header.internship')

      expect(page).to have_content t('internships.internship_details')
      expect(page).to have_content t('internships.create_internship')

      click_on t('internships.provide_now')
      expect(page).to have_content t('internships.details')
      fill_in(
        t('activerecord.attributes.complete_internship.semester_of_study'),
        with: 5
      )
      click_on t('buttons.save')

      expect(page).to have_content 'B20'
      click_on t('complete_internships.new_tp0')
      expect(page).to have_content 'Neues Praktikum'
      click_on 'Speichern'
    end
    context 'with student with internship' do
    end
  end
end
