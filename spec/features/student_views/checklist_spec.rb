# frozen_string_literal: true

require 'rails_helper'
module CheckListHelper
  describe 'Checklist Pageflow' do
    def create_internship
      create(:semester)
      visit my_internship_path
      click_on t('complete_internships.new_tp0')
      expect(page).to have_field('Semester')
      click_on t('save')
    end

    def create_complete_internship
      visit my_internship_path
      expect(page).to have_content('Praktikumsdetails')
      click_link(t('internships.provide_now'))
      click_on t('save')
      expect(page).to have_content(@user.name)
    end

    def expect_to_be_on_my_internship_page
      expect(page).to have_content(@user.name)
      expect(page).to have_content(t('complete_internships.semester')
                                 .strip)
    end

    I18n.available_locales.each do |locale|
      context "in locale #{locale}" do
        before :each do
          I18n.locale = locale
          allow_ldap_login(success: false)
        end
        list = if ENV['WITH_ADMIN']
                 %w[student admin]
               else
                 %w[student]
               end
        list.each do |role|
          context "as #{role}" do
            before :each do
              @user = send "login_as_#{role}"
              create_complete_internship
              create_internship
            end

            context 'back to complete internship' do
              context ' from internship details' do
                before(:each) do
                  visit my_internship_path
                  click_link(t('internships.internship_details'))
                  expect(page).to have_content(
                    t('activerecord.attributes.internship.supervisor_name')
                  )
                end
                it 'without save' do
                  click_on t('buttons.back_to_overview')
                  expect_to_be_on_my_internship_page
                end
                it 'after save' do
                  click_on t('save')
                  # currently jumps back to overview immediately
                  #click_on t('buttons.back')
                  # click_on t('buttons.back_to_overview')
                  expect_to_be_on_my_internship_page
                end
              end
              context ' from personal details' do
                before(:each) do
                  visit my_internship_path
                  click_link(
                    t('complete_internships.checklist.personal_details')
                  )
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
      end
    end
  end
end
