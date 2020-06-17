# frozen_string_literal: true

require 'rails_helper'

describe 'Internship limit' do
  def create_complete_internship
    @ci = create(:complete_internship_w_fresh_internship)
    @user = @ci.student.user
    visit complete_internship_path(id: @ci.id)
    expect(page).to have_content(t('complete_internships.semester'))
  end

  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end

      context 'is counted correctly' do
        before :each do
          10.times do
            create(
              :internship,
              start_date: Date.today.to_date - 7.days,
              payment_state_id: 6
            )
          end
          10.times do
            create(
              :internship_1,
              start_date: Date.today.to_date - 7.days,
              payment_state_id: 6 # 6 equals paid
            )
          end

          @current_user = login_as_student
          visit start_search_path
        end

        context 'when making no query' do
          it 'is empty' do
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(0)
          end
        end

        context 'when making one query' do
          it 'with one result' do
            internship = create(
              :internship_1,
              start_date: Date.today.to_date - 7.days,
              payment_state_id: 5, # 5 equals uncharted
            )
            select t('search.is_not_paid'), from: 'search_paid'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 1.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(page).to have_content(
              internship.company_address.company.name
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(1)
          end

          it 'with no results' do
            select t('search.is_not_paid'), from: 'search_paid'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 0.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(0)
          end

          it 'with loads of results' do
            click_on t('search.buttons.search')
            click_on t('search.modal.confirm')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 12.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(12)
          end

          it 'with loads of results that the user resets' do
            click_on t('search.buttons.search')
            click_on t('search.modal.dismiss')
            expect(page).not_to have_content(
              t('search.results_found.start').to_s
            )
            expect(page).not_to have_content(
              t('search.results_found.finish').to_s
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(0)
          end
        end

        context 'when making multiple queries' do
          it 'with same results' do
            5.times do
              create(
                :internship_1,
                start_date: Date.today.to_date - 7.days,
                payment_state: nil,
                salary: -5
              )
            end
            select t('search.is_not_paid'), from: 'search_paid'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 5.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(5)

            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 5.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(5)
          end

          it 'with different results' do
            5.times do
              create(
                :internship_1,
                start_date: Date.today.to_date - 7.days,
                payment_state: nil,
                salary: -5
              )
            end
            select t('search.is_not_paid'), from: 'search_paid'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 5.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(5)

            select t('search.is_paid'), from: 'search_paid'
            click_on t('search.buttons.search')
            click_on t('search.modal.confirm')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 7.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(
              UserCanSeeInternship
              .number_of_viewed_internships_for_user(user: @current_user)
            ).to equal(12)
          end
        end
      end
    end
  end
end
