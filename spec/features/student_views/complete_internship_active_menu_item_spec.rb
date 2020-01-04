# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = @locale = locale
        allow_ldap_login(success: false)
      end
      context 'with valid user credentials' do
        before :each do
          @user = login_as_student
        end

        it 'should mark complete internship as active' do
          visit my_internship_path_replacement
          expect(page).to have_css('.im-nav-itemactive')
        end

        it 'should mark internship offers as active' do
          visit internship_offers_path(locale: @locale)
          expect(page).to have_css('.im-nav-itemactive')
          n = find('li.im-nav-itemactive > a')
          expect(n['href']).to eq internship_offers_path(locale: @locale)
        end
      end
    end
  end
end
