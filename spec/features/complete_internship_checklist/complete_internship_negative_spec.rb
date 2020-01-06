# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      def log_in_with_unknown_email
        visit root_path
        email = 's0987654@htw-berlin.de'
        fill_in 'user_email', with: email
        fill_in 'user_password', with: 'geheim13'
        click_on('Log in')
        User.find_by(email: email)
      end
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: true)
        @user = log_in_with_unknown_email
      end

      context 'first login' do
        it 'should proceed to log in and back to original page' do
          expect(page).to have_content I18n.t('devise.sessions.signed_in')
        end

        it 'should save internship without student data' do
          create(:semester)
          visit my_internship_path_replacement
          click_button(t('internships.provide_now'))
          click_link(t('consent.ok_cool'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(t('complete_internships.semester'))
        end
      end
    end
  end
end
