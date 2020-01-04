# frozen_string_literal: true

require 'rails_helper'
require_relative './checklist_helper.rb'
describe 'Checklist Pageflow' do
  include CompleteInternshipCheckListHelper
  #  I18n.available_locales.each do |locale|
  context 'locale' do
    before :each do
      #  I18n.locale = locale
      allow_ldap_login(success: false)
      @user = login_with(user_factory: :user)
      create_complete_internship
      create_internship
      visit my_internship_path_replacement
    end
    it 'is on complete internship overview' do
      expect_to_be_on_my_internship_page
    end

    context 'back to complete internship' do
      context ' from internship details' do
        before(:each) do
          click_link(t('internships.internship_details'))
        end
        it 'is on internship details page' do
          expect(page).to have_content(
            t('activerecord.attributes.internship.supervisor_name')
          )
        end
        it 'back without save without save' do
          click_on t('buttons.back_to_overview')
          expect_to_be_on_my_internship_page
        end
        it 'after save' do
          click_on t('save')
          click_on t('buttons.back')
          expect_to_be_on_my_internship_page
        end
      end
      context ' from personal details' do
        before(:each) do
          click_link(
            t('complete_internships.checklist.personal_details')
          )
        end
        it 'is on personal details page' do
          expect(page)
            .to have_content(
              t('activerecord.attributes.student.birthday')
            )
        end
        it ' without save' do
          click_on t('buttons.back_to_overview')
          expect_to_be_on_my_internship_page
        end

        it ' from personal details after save' do
          click_on t('helpers.submit.generic_update')
          click_on t('buttons.back_to_overview')
          expect_to_be_on_my_internship_page
        end
      end
    end
  end
end
