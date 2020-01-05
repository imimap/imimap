# frozen_string_literal: true

require 'rails_helper'
module CheckListHelper
  describe 'Checklist Pageflow' do
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
              complete_internship = create(:complete_internship,
                                           student: @user.student)
              create(:internship_without_states,
                     complete_internship: complete_internship)
            end

            context 'back to complete internship' do
              it ' from company details' do
                visit my_internship_path_replacement
                click_link(t('complete_internships.checklist.company_details'))
                expect(page)
                  .to have_content(
                    t('activerecord.attributes.company.number_employees')
                  )
                click_on t('companies.continue_to_address')
                # click_on t('helpers.submit.generic_update')
                # click_on t('buttons.save')
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
