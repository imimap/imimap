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
  # I18n.available_locales.each do |locale|
  # context "in locale #{locale}" do
  before :each do
    #    I18n.locale = locale
    # allow_ldap_login(success: false)
  end
  context 'with existing student login' do
    before :each do
      @user = login_as_student
    end

    it 'should show a limited number of companies altogether' do
      create(:semester)
      companies = [
        create(:company_1),
        create(:company_2),
        create(:company_3),
        create(:company_4),
        create(:company_5),
        create(:company_is24)
      ]

      visit my_internship_path_replacement
      click_link(t('internships.provide_now'))
      click_on t('save')
      click_on t('complete_internships.new_tp0')

      click_on t('save')
      click_on t('complete_internships.checklist.company_details')

      companies[0..4].each do |company|
        fill_in(:name, with: company.name)
        click_on t('companies.continue2')
        click_on company.name, match: :first
        click_on t('activerecord.attributes.company_address.back_to_select')
      end
      company = companies[5]
      fill_in(:name, with: company.name)
      click_on t('companies.continue2')
      click_on company.name, match: :first
      expect(page).not_to(
        have_content(company.company_addresses.first.street)
      )
    end
  end
  #  end
  #  end
end
