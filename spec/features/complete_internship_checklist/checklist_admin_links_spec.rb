# frozen_string_literal: true

require 'rails_helper'
describe 'Checklist - Special Admin Content' do
  def expect_to_be_on_my_internship_page
    expect(page).to have_content(@user.name)
    expect(page).to have_content(t('complete_internships.semester')
                                     .strip)
  end

  def expect_to_not_see_admin_stuff
    expect(page).not_to have_content(
      t('complete_internships.checklist.internal_comments')
    )
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

  # def expect_to_see_admin_stuff
  #   expect(page).to have_content(
  #     t('complete_internships.checklist.internal_comments')
  #   )
  #   expect_to_see_active_admin_links
  #   expect_to_see_modules
  # end

  # def expect_to_see_modules
  #   expect(page).to have_content(
  #     t('complete_internships.checklist.module_semester')
  #  )
  #   expect(page).to have_content t 'complete_internships.checklist.module_fgr'
  # end

  # def expect_to_see_active_admin_links
  #   expect(page).to have_content '(In Active Admin'
  #   expect(page).to have_content t('complete_internships.checklist.see_aa')
  #   expect(page).to have_content t('complete_internships.checklist.edit_aa')
  #  end

  #  I18n.available_locales.each do |locale|
  context 'locale' do
    user_factories = [:student_with_internship]
    user_factories.each do |factory_name|
      context "as #{factory_name}" do
        before :each do
          @user = login_with(user_factory: factory_name)
          visit my_internship_path_replacement
        end

        it { expect_not_to_see_modules }
        it { expect_to_not_see_active_admin_links }
        it { expect_to_not_see_admin_stuff }
      end
    end
  end
end
