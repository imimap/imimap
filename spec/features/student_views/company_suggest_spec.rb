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
      context 'with valid user credentials' do
        before :each do
          @user = login_as_student
        end

        it 'should tell me there was no match' do
          create(:semester)
          visit my_internship_path
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
            t('companies.no_match1')
          )
          page_contains_search
        end

        it 'should show me only similar matches' do
          create(:semester)
          create(:company_1)
          create(:company_2)
          create(:company_is24)
          visit my_internship_path
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
          fill_in(:name, with: 'CoMp')
          click_on t('companies.continue2')
          page_contains_search
          expect(page).to have_content(
            t('companies.suggestion')
          )
          expect(page).to have_content(
            'Company 1'
          )
          expect(page).not_to have_content(
            t('companies.no_match1')
          )
          expect(page).not_to have_content(
            'Immobilienscout'
          )
          page_contains_search
        end

        it 'should not progress when no name was given' do
          create(:semester)
          visit my_internship_path
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

        it 'shouldnt show the link for creating a new company when theres one
            with the exact same name' do
          create(:semester)
          create(:company_1)
          create(:company_2)
          visit my_internship_path
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
      end
    end
  end
end
