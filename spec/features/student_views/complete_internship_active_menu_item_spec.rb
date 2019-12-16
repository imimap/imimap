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

        it 'should mark complete internship as active' do
          visit my_internship_path
          expect(page).to have_css('.active')
        end
      end
    end
  end
end
