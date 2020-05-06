# frozen_string_literal: true

require 'rails_helper'

def create_companies
  create_companies_fuzzy
  create_companies_exact
end

def create_companies_fuzzy
  create(:company, name: 'Match_1_SomeMoreStuff')
  create(:company, name: 'Match_2_SomeMoreStuff_1')
  create(:company, name: 'Match_2_SomeMoreStuff_2')
  create(:company, name: 'Match_3_SomeMoreStuff_1')
  create(:company, name: 'Match_3_SomeMoreStuff_2')
  create(:company, name: 'Match_3_SomeMoreStuff_3')
  create(:company, name: 'Match_4_SomeMoreStuff_1')
  create(:company, name: 'Match_4_SomeMoreStuff_2')
  create(:company, name: 'Match_4_SomeMoreStuff_3')
  create(:company, name: 'Match_4_SomeMoreStuff_4')
end

def create_companies_exact
  create(:company, name: 'Match_5_SomeMoreStuff_1')
  create(:company, name: 'Match_5_SomeMoreStuff_2')
  create(:company, name: 'Match_5_SomeMoreStuff_3')
  create(:company, name: 'Match_5_SomeMoreStuff_4')
  create(:company, name: 'Match_5_SomeMoreStuff_5')

  create(:company, name: 'Match_6_SomeMoreStuff_1')
  create(:company, name: 'Match_6_SomeMoreStuff_2')
  create(:company, name: 'Match_6_SomeMoreStuff_3')
  2.times { create(:company, name: 'Match_6') }

  6.times { create(:company, name: 'Match_7') }
end

def go_to_search
  visit my_internship_path_replacement
  click_button(t('internships.provide_now'))
  click_link(t('consent.ok_cool'))
  click_on t('save')
  click_on t('complete_internships.new_tp0')
  click_on t('save')
  click_on t('complete_internships.checklist.company_details')
end

def search_for(company_name:)
  go_to_search
  fill_in(:name, with: company_name)
  click_on t('companies.continue2')
end

def search_for_with_existing_ci(company_name:)
  visit my_internship_path_replacement
  click_on t('complete_internships.checklist.company_details')
  fill_in(:name, with: company_name)
  click_on t('companies.continue2')
end

describe 'Company Suggestion Cases' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'with existing student login' do
        before :each do
          @user = login_as_student
          create_companies
        end

        it 'companies are correctly created' do
          # expect(Company.count).to eq 6
          # expect(Company.all.pluck(:name)).to eq ""
          expect(Company.with_fuzzy_name('Match_0').count).to eq 0
          expect(Company.with_fuzzy_name('Match_1').count).to eq 1
          expect(Company.with_fuzzy_name('Match_2').count).to eq 2
          expect(Company.with_fuzzy_name('Match_3').count).to eq 3
          expect(Company.with_fuzzy_name('Match_4').count).to eq 4
          expect(Company.with_fuzzy_name('Match_5').count).to eq 5
          expect(Company.with_name('Match_5').count).to eq 0
          expect(Company.with_fuzzy_name('Match_6').count).to eq 5
          expect(Company.with_name('Match_6').count).to eq 2
          expect(Company.with_fuzzy_name('Match_7').count).to eq 6
          expect(Company.with_name('Match_7').count).to eq 6
        end

        # there are 5 cases:
        # 1) no matches where found for fuzzy search. Match_0
        # 2) acceptable amount was found for fuzzy search. Match_1, Match_2,
        #    Match_3. Match4
        # 3) too many where found for fuzzy search, and none with exact search.
        #    Match_5
        # 4) too many for fuzzy, acceptable amount was found for exact search.
        #    Match_6
        # 5) too many where found for exact search. Match_7

        it '1) no matches where found for fuzzy search.' do
          search_for(company_name: 'Match_0')
          expect(page).to have_content(t('companies.no_match'))
        end
        %w[Match_1 Match_2 Match_3].each do |company_name|
          it "2) acceptable amount found for fuzzy search. #{company_name}" do
            search_for(company_name: company_name)

            expect(page).to have_content(t('companies.suggestion'))
          end
        end
        it ' 3) too many found for fuzzy search, and none with exact search.' do
          search_for(company_name: 'Match_5')
          expect(page).to have_content(t('companies.too_many'))
        end
        it '4) too many for fuzzy, acceptable amount found for exact search.' do
          search_for(company_name: 'Match_6')
          expect(page).to have_content(t('companies.suggestion'))
        end
        it '5) too many were found for exact search.' do
          search_for(company_name: 'Match_7')
          expect(page).to have_content(t('companies.too_many'))
        end

        it 'should show me no suggestions when Ive exceeded my search limit' do
          search_for(company_name: 'Match_5_SomeMoreStuff_1')
          search_for_with_existing_ci(company_name: 'Match_1')
          search_for_with_existing_ci(company_name: 'Match_2')
          search_for_with_existing_ci(company_name: 'Match_3')
          search_for_with_existing_ci(company_name: 'Match_4')
          search_for_with_existing_ci(company_name: 'Match_5_SomeMoreStuff_2')
          search_for_with_existing_ci(company_name: 'Match_5_SomeMoreStuff_3')
          expect(page).to have_content(t('companies.limit_exceeded'))
        end

        it 'should show me no suggestions when Ive exceeded my suggest limit' do
          search_for(company_name: 'Match_4_SomeMoreStuff_1')
          click_link('Match_4_SomeMoreStuff_1', class: 'suggest')
          search_for_with_existing_ci(company_name: 'Match_1_SomeMoreStuff')
          click_link('Match_1_SomeMoreStuff', class: 'suggest')
          search_for_with_existing_ci(company_name: 'Match_2_SomeMoreStuff_1')
          click_link('Match_2_SomeMoreStuff_1', class: 'suggest')
          search_for_with_existing_ci(company_name: 'Match_2_SomeMoreStuff_2')
          click_link('Match_2_SomeMoreStuff_2', class: 'suggest')
          search_for_with_existing_ci(company_name: 'Match_3_SomeMoreStuff_1')
          click_link('Match_3_SomeMoreStuff_1', class: 'suggest')
          search_for_with_existing_ci(company_name: 'Match_3_SomeMoreStuff_2')
          expect(page).to have_content(t('companies.limit_exceeded'))
        end
      end
    end
  end
end
