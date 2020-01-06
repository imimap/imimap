# frozen_string_literal: true

require 'rails_helper'

describe 'Complete Internship' do
  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      list = if ENV['WITH_ADMIN']
               %w[student admin]
             else
               %w[student]
             end
      list.each do |role|
        before :each do
          I18n.locale = locale
          allow_ldap_login(success: false)
          # @user = login_as_student
          @user = send "login_as_#{role}"
        end

        context 'with no internship created' do
          before :each do
            visit my_internship_path_replacement
            click_button(t('internships.provide_now'))
            click_link(t('consent.ok_cool'))
            click_on t('save')
          end

          it 'should not display hash' do
            expect(page).not_to have_content(
              '{false=>"still open", true=>"passed"}'
            )
            expect(page).not_to have_content(
              '{false=>"noch offen", true=>"bestanden"}'
            )
          end
        end

        context 'with 1 internship created' do
          before :each do
            create(:semester)
            visit my_internship_path_replacement
            click_button(t('internships.provide_now'))
            click_link(t('consent.ok_cool'))
            click_on t('save')
            click_on t('complete_internships.new_tp0')
            click_on t('save')
          end

          it 'new internship should not be approved' do
            internship = @user.student.internships.first
            expect(internship).not_to be_approved
          end

          it '- no start/end_dates provided,
          should not display hash' do
            expect(page).not_to have_content(
              '{false=>"still open", true=>"passed"}'
            )
          end

          it '- not long enough
          should display "still open/noch offen"' do
            click_link(t('internships.internship_details'))
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.1.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: '2.4.2019'
            click_on t('save')
            expect(page).to have_content(
              t('complete_internships.parcial_internships.values.false'),
              count: 3
            )
          end

          it '- long enough but not over
          should display "still open/noch offen"' do
            click_link(t('internships.internship_details'))
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.1.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: Date.tomorrow
            click_on t('save')
            expect(page).to have_content(
              t('complete_internships.parcial_internships.values.false'),
              count: 3
            )
          end

          it '- long enough and over
          should display "passed/bestanden"' do
            click_link(t('internships.internship_details'))
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.1.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: '30.5.2019'
            click_on t('save')
            expect(page).to have_content(
              t('complete_internships.parcial_internships.values.true')
            )
          end
        end

        context 'with two partial internships created' do
          before :each do
            create(:semester)
            visit my_internship_path_replacement
            click_button(t('internships.provide_now'))
            click_link(t('consent.ok_cool'))
            click_on t('save')
            click_on t('complete_internships.new_tp0')
            click_on t('save')
            click_on t('complete_internships.new_tp')
            click_on t('save')
          end

          it '- not long enough together
          should display "still open/noch offen"' do
            all('a', text: t('internships.internship_details'))[0].click
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.1.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: '1.2.2019'
            click_on t('save')
            all('a', text: t('internships.internship_details'))[1].click
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.3.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: '1.4.2019'
            click_on t('save')
            expect(page).to have_content(
              t('complete_internships.parcial_internships.values.false'),
              count: 3
            )
          end

          it '- long enough together but not over
          should display "still open/noch offen"' do
            all('a', text: t('internships.internship_details'))[0].click
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.1.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: '1.2.2019'
            click_on t('save')
            all('a', text: t('internships.internship_details'))[1].click
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.3.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: Date.tomorrow
            click_on t('save')
            expect(page).to have_content(
              t('complete_internships.parcial_internships.values.false'),
              count: 3
            )
          end

          it '- long enough and over
          should display "passed/bestanden"' do
            all('a', text: t('internships.internship_details'))[0].click
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.1.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: '1.2.2019'
            click_on t('save')
            all('a', text: t('internships.internship_details'))[1].click
            fill_in t('activerecord.attributes.internship.start_date'),
                    with: '1.3.2019'
            fill_in t('activerecord.attributes.internship.end_date'),
                    with: '1.9.2019'
            click_on t('save')
            expect(page).to have_content(
              t('complete_internships.parcial_internships.values.true')
            )
          end
        end
      end
    end
  end
end
