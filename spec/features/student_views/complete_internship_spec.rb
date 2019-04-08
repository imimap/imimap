# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'with valid user credentials' do
        before :each do
          @user = login_as_student
        end

        it 'should create a new CI' do
          visit my_internship_path
          expect(page).to have_content('Praktikumsdetails')
          click_link(t('internships.createYourInternship'))
          expect(page).to have_field('Semester')
          expect(page).to have_field('Fachsemester')
          click_on t('save')
          expect(page).to have_content(@user.name)
        end

        it 'should create a new partial internship' do
          visit my_internship_path
          click_link(t('internships.createYourInternship'))
          click_on t('save')
          click_on t('complete_internships.new_tp')
          expect(page).to have_field('Semester')
          click_on t('save')
          # not finished yet
        end
      end
    end
  end
end
