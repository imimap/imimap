# frozen_string_literal: true

require 'rails_helper'

describe 'Supply Company Details' do
#I18n.available_locales.each do |locale|
#  context "in locale #{locale}" do
#      before :each do
#        I18n.locale = locale
#      end
      context 'with student user and now Comany Information' do
        before :each do
          @user = create(:student_user_with_internship_company_wo_address)
          login_as(@user)
          create(:semester)
          @company_name = 'The Backend Company'
          ca = build(:plain_company_address)
        end

        it 'should create company' do
          visit my_internship_path
          click_on t('complete_internships.checklist.company_details')
          # fill_in :company_name_for_search, @company_name
          save_and_open_page
          fill_in :name, with: @company_name
          click_on t('companies.continue2')
          expect(page).to have_link(
            @company_name
          )
          click_on @company_name
          expect(page).to have_content('Neue Firma Erstellen')
          click_on 'Weiter zur Adresse'
          expect(page).to have_content('Erstelle eine neue Firmenaddresse')
          @company_address.attributes_required_for_save.each do | field |
            fill_in field, with:
          end

        end
      end
#    end
#  end
end
