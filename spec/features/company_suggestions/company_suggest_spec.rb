# frozen_string_literal: true

require 'rails_helper'

def page_contains_search
  expect(page).to have_content(
    t('companies.select.companyname')
  )
  expect(page).to have_content(
    t('companies.give_name')
  )
end

describe 'Company Suggestion' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'with existing student login' do
        before :each do
          @user = login_as_student
        end

        it 'should tell me there was no match' do
          create(:semester)
          visit my_internship_path_replacement
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          click_on t('complete_internships.checklist.company_details')
          page_contains_search
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          fill_in(:name, with: 'Testfirma')
          click_on t('companies.continue2')
          expect(page).not_to have_content(
            t('companies.suggestion')
          )
          expect(page).to have_content(
            t('companies.no_match')
          )
          page_contains_search
        end

        it 'should show me only similar matches' do
          create(:semester)

          create(:company_2)
          create(:company_is24)
          visit my_internship_path_replacement
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          click_on t('complete_internships.checklist.company_details')
          page_contains_search
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          fill_in(:name, with: 'Immobilien')
          click_on t('companies.continue2')
          page_contains_search
          expect(page).to have_content(
            t('companies.suggestion')
          )

          expect(page).not_to have_content(
            t('companies.no_match')
          )
          expect(page).to have_content(
            'Immobilienscout'
          )
          page_contains_search
        end

        it 'should not progress when no name was given' do
          create(:semester)
          visit my_internship_path_replacement
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          click_on t('complete_internships.checklist.company_details')
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          # click_on t('companies.continue')
          # message = page.find("#name").native.attribute("validationMessage")
          # expect(message).to eq "Please fill out this field."
        end

        it "shouldn't show the link for creating a new company when theres one
            with the exact same name" do
          create(:semester)
          create(:company_1)
          create(:company_2)
          visit my_internship_path_replacement
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          click_on t('complete_internships.checklist.company_details')
          page_contains_search
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          fill_in(:name, with: 'Company 1')
          click_on t('companies.continue2')
          expect(page).to have_link(
            'Company 1'
          )
          page_contains_search
        end

        it 'no match when too many results and no exact match' do
          create(:semester)
          create(:company_1)
          create(:company_2)
          create(:company_is24)
          create(:company_is24)
          create(:company_is24)
          visit my_internship_path_replacement
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          click_on t('save')
          click_on t('complete_internships.checklist.company_details')
          page_contains_search
          expect(page).to have_content(
            t('companies.select.companyname')
          )
          fill_in(:name, with: 'o')
          click_on t('companies.continue2')
          expect(page).not_to have_content(
            t('companies.suggestion')
          )
          expect(page).to have_content(
            t('companies.too_many')
          )
          page_contains_search
        end

        context 'with company match' do
          before :each do
            create(:semester)
            create(:company_1)
            create(:company_2)
            create(:company_m)
            @company = create(:company_is24)

            visit my_internship_path_replacement
            click_link(t('internships.provide_now'))
            click_on t('save')
            click_on t('complete_internships.new_tp0')
            click_on t('save')
            click_on t('complete_internships.checklist.company_details')
            page_contains_search
            expect(page).to have_content(
              t('companies.select.companyname')
            )
          end
          it 'match when too many results and one exact match' do
            fill_in(:name, with: 'M')
            click_on t('companies.continue2')
            expect(page).to have_content(
              t('companies.suggestion')
            )
            expect(page).to have_content(
              t('companies.create_new_company')
            )
            expect(page).to have_link(
              'M'
            )
            page_contains_search
          end
          it 'links to the address successfully' do
            fill_in(:name, with: @company.name)
            click_on t('companies.continue2')

            click_on @company.name, match: :first
            click_on @company.company_addresses.first.address
            expect(page).not_to have_content('AccessDenied')
            click_on t('activerecord.attributes.company_address.submit')
            id_via_c = @company.company_addresses.first.internships.first.id
            id_via_u = @user.student.internships.first.id
            expect(id_via_u).to eq id_via_c
          end
        end
      end
    end
  end
end
