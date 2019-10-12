# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end
      context 'with valid user credentials' do
        before :each do
          @user = login_as_student
        end

        it 'should create a new CI' do
          visit my_internship_path
          expect(page).to have_content('Praktikumsdetails')
          click_link(t('internships.provide_now'))
          expect(page).to have_field('Semester')
          expect(page).to have_field('Fachsemester')
          click_on t('save')
          expect(page).to have_content(@user.name)
        end

        it 'should create a new partial internship' do
          create(:semester)
          visit my_internship_path
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          expect(page).to have_field('Semester')
          click_on t('save')
          expect(page).to have_content('Tuennes Schael')
          expect(page).to have_content(
            t('complete_internships.aep.number')
          )
          expect(page).to have_content(
            t('complete_internships.parcial_internships.number')
          )
          expect(page).to have_content(
            t('complete_internships.ci.number')
          )
          save_and_open_page
          expect(page).to have_content(Semester.last.name)
        end

        it 'should save changes made in internship datails form
            (example supervisor details)' do
          create(:semester)
          visit my_internship_path
          click_link(t('internships.provide_now'))
          click_on t('save')
          click_on t('complete_internships.new_tp0')
          click_on t('save')
          click_link(t('internships.internship_details'))
          expect(page).to have_content(
            t('activerecord.attributes.internship.supervisor_name')
          )
          expect(page).to have_content(
            t('activerecord.attributes.internship.supervisor_email')
          )
          expect(page).to have_content(
            t('activerecord.attributes.internship.supervisor_phone')
          )

          fill_in t('activerecord.attributes.internship.supervisor_phone'),
                  with: '030283020'
          fill_in t('activerecord.attributes.internship.supervisor_name'),
                  with: 'Testname'
          fill_in t('activerecord.attributes.internship.supervisor_email'),
                  with: 'meineMail@whatsoever.com'
          click_on t('save')
          click_link(t('complete_internships.checklist.internship_details'))
          expect(find_field(
            t('activerecord.attributes.internship.supervisor_phone')
          )
                  .value).to eq '030283020'
          expect(find_field(
            t('activerecord.attributes.internship.supervisor_email')
          )
                  .value).to eq 'meineMail@whatsoever.com'
          expect(find_field(
            t('activerecord.attributes.internship.supervisor_name')
          )
                  .value).to eq 'Testname'
        end
      end
    end
  end
end
