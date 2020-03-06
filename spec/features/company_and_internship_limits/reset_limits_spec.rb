# frozen_string_literal: true

require 'rails_helper'

describe 'Reset limit' do
  def create_complete_internship
    @ci = create(:complete_internship_w_fresh_internship)
    @user = @ci.student.user
    visit complete_internship_path(id: @ci.id)
    expect(page).to have_content(t('complete_internships.semester'))
  end

  def expect_zero_limits
    expect(page).to have_content('0/12', count: 2)
    expect(page).to have_content('0/5')
  end

  def expect_three_reset_buttons
    expect(page).to have_button('Reset', count: 3)
  end

  def expext_three_limits
    expect(page).to have_content('Limit - ', count: 3)
  end

  def expect_reset_headings
    expect(page).to have_content('Company Suggest')
    expect(page).to have_content('Company Search')
    expect(page).to have_content('Internship Search')
  end

  def expext_flash_message
    expect(page).to have_content('Reset successful')
  end

  def expect_ci_show_zero_limits
    expect_zero_limits
    expect_three_reset_buttons
    expext_three_limits
    expect_reset_headings
  end

  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end

      context 'ci#show' do
        before :each do
          login_as_admin
          create_complete_internship
        end

        context 'displays' do
          it 'correct numbers for limits' do
            expect_zero_limits
          end

          it 'three Reset-Buttons' do
            expect_three_reset_buttons
          end

          it 'three Reset-Headings' do
            expext_three_limits
            expect_reset_headings
          end
        end
      end

      context 'resetting' do
        before :each do
          login_as_admin
          create_complete_internship
        end

        context 'renders ci#show again' do
          it 'when internship-limit of 0' do
            click_button('Reset', id: 'internship_search')
            expect_ci_show_zero_limits
            expext_flash_message
          end

          it 'when company_search-limit of 0' do
            click_button('Reset', id: 'company_search')
            expect_ci_show_zero_limits
            expext_flash_message
          end

          it 'when company_suggest-limit of 0' do
            click_button('Reset', id: 'company_suggest')
            expect_ci_show_zero_limits
            expext_flash_message
          end
        end

        context 'removes' do
          before :each do
            create(:user_can_see_internship, user: @user)
            visit complete_internship_path(id: @ci.id)
          end

          it 'internship-limit' do
            expect(page).to have_content("Limit - Internship Search\n1/12")

            click_button('Reset', id: 'internship_search')
            expect_ci_show_zero_limits
            expext_flash_message
          end
        end

        context 'removes' do
          before :each do
            create(:user_can_see_company, user: @user, created_by: 2)
            visit complete_internship_path(id: @ci.id)
          end

          it 'company_search-limit' do
            expect(page).to have_content("Limit - Company Search\n1/12")

            click_button('Reset', id: 'company_search')
            expect_ci_show_zero_limits
            expext_flash_message
          end
        end

        context 'removes' do
          before :each do
            create(:user_can_see_company, user: @user, created_by: 1)
            visit complete_internship_path(id: @ci.id)
          end

          it 'company_suggest-limit' do
            expect(page).to have_content("Limit - Company Suggest\n1/5")

            click_button('Reset', id: 'company_suggest')
            expect_ci_show_zero_limits
            expext_flash_message
          end
        end
      end
    end
  end
end
