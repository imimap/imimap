# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
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
          end

          it 'should create a new CI' do
            visit my_internship_path_replacement
            expect(page).to have_content('Praktikumsdetails')
            click_button(t('internships.provide_now'))
            click_link(t('consent.ok_cool'))
            expect(page).to have_field('Semester')
            expect(page).to have_field('Fachsemester')
            click_on t('save')
            expect(page).to have_content(@user.name)
          end

          it 'should create a new partial internship' do
            create(:semester)
            semester = Semester.first
            visit my_internship_path_replacement
            click_button(t('internships.provide_now'))
            click_link(t('consent.ok_cool'))
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
            expect(page).to have_content(semester.name)
          end

          it 'should delete a partial internship' do
            create(:semester)
            visit my_internship_path_replacement
            click_button(t('internships.provide_now'))
            click_link(t('consent.ok_cool'))
            click_on t('save')
            click_on t('complete_internships.new_tp0')
            click_on t('save')
            expect(page).to have_content(
              "#{t('complete_internships.internship')} @"
            )
            click_button 'x'
            expect(page).not_to have_content(
              "#{t('complete_internships.internship')} @"
            )
          end

          it 'should save changes made in internship datails form
              (example supervisor details)' do
            create(:semester)
            visit my_internship_path_replacement
            click_button(t('internships.provide_now'))
            click_link(t('consent.ok_cool'))
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
end
