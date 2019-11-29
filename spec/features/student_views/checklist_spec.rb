# frozen_string_literal: true

require 'rails_helper'

describe 'Checklist Pageflow' do

  def create_complete_internship
    visit my_internship_path
    expect(page).to have_content('Praktikumsdetails')
    click_link(t('internships.provide_now'))
    expect(page).to have_field('Semester')
    expect(page).to have_field('Fachsemester')
    click_on t('save')
    expect(page).to have_content(@user.name)
  end

  def create_internship
    create(:semester)
    visit my_internship_path
    click_on t('complete_internships.new_tp0')
    expect(page).to have_field('Semester')
    click_on t('save')
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
        context 'with valid user credentials' do
          before :each do
            @user = send "login_as_#{role}"
            create_complete_internship
            create_internship
          end

          context 'go back to complete internship' do
            it ' from internship details' do
              visit my_internship_path

              click_link(t('internships.internship_details'))
              expect(page).to have_content(
                t('activerecord.attributes.internship.supervisor_name')
              )
              click_on t('save')
              click_on t('buttons.back_to_overview')
              expect_to_be_on_my_internship_page
            end
            it ' from personal details' do
              visit my_internship_path
              click_link(t('complete_internships.checklist.personal_details'))
              expect(page)
                .to have_content(t('activerecord.attributes.student.birthday'))
              click_on t('helpers.submit.generic_update')
              save_and_open_page
              click_on t('buttons.back_to_overview')
              expect_to_be_on_my_internship_page
            end
          end
        end
      end
    end
  end
end
