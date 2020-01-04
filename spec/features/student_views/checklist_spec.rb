# frozen_string_literal: true

require 'rails_helper'
describe 'Checklist Pageflow' do
  def create_complete_internship
    visit my_internship_path_replacement
    expect(page).to have_content('Praktikumsdetails')
    click_link(t('internships.provide_now'))
    click_on t('save')
    expect(page).to have_content(@user.name)
  end

  def create_internship
    create(:semester)
    visit my_internship_path_replacement
    click_on t('complete_internships.new_tp0')
    expect(page).to have_field('Semester')
    click_on t('save')
  end

  def expect_to_be_on_my_internship_page
    expect(page).to have_content(@user.name)
    expect(page).to have_content(t('complete_internships.semester')
                               .strip)
  end

  def expect_to_not_see_admin_stuff
    expect(page).not_to have_content(
      t('complete_internships.checklist.internal_comments')
    )
    expect_to_not_see_active_admin_links
    expect_not_to_see_modules
  end

  def expect_not_to_see_modules
    expect(page).not_to have_content(
      t('complete_internships.checklist.module_semester')
    )
    expect(page).not_to have_content(
      t('complete_internships.checklist.module_fgr')
    )
  end

  def expect_to_not_see_active_admin_links
    expect(page).not_to have_content '(In Active Admin'
    expect(page).not_to have_content t('complete_internships.checklist.see_aa')
    expect(page).not_to have_content t('complete_internships.checklist.edit_aa')
  end

  def expect_admin_stuff_or_not
    if @user.admin?
      # expect_to_see_admin_stuff
    else
      expect_to_not_see_admin_stuff
    end
  end

  #  I18n.available_locales.each do |locale|
  context 'locale' do
    before :each do
      #  I18n.locale = locale
      allow_ldap_login(success: false)
    end
    # list = if ENV['WITH_ADMIN']
    #          %w[student admin]
    #        else
    #          %w[student]
    #        end
    #  list.each do |role|
    #  context 'as role' do
    #    # context "as #{role}" do
    #  end
    before :each do
      role = 'student'
      @user = send "login_as_#{role}"
      create_complete_internship
      create_internship
    end

    context 'back to complete internship' do
      context ' from internship details' do
        before(:each) do
          visit my_internship_path_replacement
          click_link(t('internships.internship_details'))
          expect(page).to have_content(
            t('activerecord.attributes.internship.supervisor_name')
          )
        end
        it 'without save' do
          click_on t('buttons.back_to_overview')
          expect_to_be_on_my_internship_page
        end
        it '

after save' do
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
