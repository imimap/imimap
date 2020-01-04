# frozen_string_literal: true

require 'rails_helper'
describe 'Checklist Pageflow' do
  def expect_to_be_on_my_internship_page
    expect(page).to have_content(@user.name)
    expect(page).to have_content(t('complete_internships.semester')
                                     .strip)
  end

  #  I18n.available_locales.each do |locale|
  context 'locale' do
    before :each do
      #  I18n.locale = locale
      allow_ldap_login(success: false)
      @user = login_with(user_factory: :student_with_new_internship)
      @internship = @user.student.internships.first
      @internship.approved = false
      @internship.passed = false
      @internship.save
    end
    it 'is on complete internship overview' do
      visit my_internship_path_replacement
      expect_to_be_on_my_internship_page
    end

    context 'back to complete internship' do
      context ' from internship details' do
        before(:each) do
          visit my_internship_path_replacement
          save_and_open_page
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
          click_on t('buttons.back')
          # click_on t('buttons.back_to_overview')
          expect_to_be_on_my_internship_page
        end
      end
      context ' from personal details' do
        before(:each) do
          visit my_internship_path_replacement
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
#  end
# end
