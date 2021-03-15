# frozen_string_literal: true

require 'rails_helper'

describe 'Internship search' do
  def create_internship_with_pl
    @internship = create(
      :internship, start_date: Date.today.to_date - 7.days
    )
    @pl = create(:programming_language)
    @internship.programming_languages = [@pl]
  end

  def create_internship_older_than_2yrs
    @internship2 = create(
      :internship_1, start_date: Date.today.to_date - 3.years
    )
  end

  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end

      context 'shows' do
        before :each do
          create_internship_with_pl
          login_as_student
          visit start_search_path
          click_on t('search.buttons.search')
        end

        context '-' do
          it 'details button' do
            expect(page).to have_button('Details')
          end

          it 'programming language' do
            expect(page).to have_content(
              t('search.headers.programming_languages')
            )
            expect(page).to have_content(
              @internship.programming_languages.map(&:name).join(', ')
            )
          end

          it 'orientation' do
            expect(page).to have_content(
              t('search.tableheaders.orientation')
            )
            expect(page).to have_content(
              @internship.orientation.name
            )
          end

          it 'location' do
            expect(page).to have_content(
              t('search.tableheaders.location')
            )
            expect(page).to have_content(
              @internship.company_address.city
            )
            expect(page).to have_content(
              @internship.company_address.country_name
            )
          end

          it 'payment' do
            expect(page).to have_content(
              t('search.headers.paid')
            )
            expect(page).to have_content(
              @internship.payment_state.name
            )
          end

          it 'tasks' do
            expect(page).to have_content(
              t('search.headers.tasks')
            )
            expect(page).to have_content(
              @internship.tasks
            )
          end

          it 'webseite' do
            expect(page).to have_content(
              t('search.headers.website')
            )
            expect(page).to have_content(
              @internship.company_address.company.website
            )
          end

          it 'semester' do
            expect(page).to have_content('Semester')
            expect(page).to have_content(
              @internship.semester.name
            )
          end

          it 'company' do
            expect(page).to have_content(
              t('search.tableheaders.orientation')
            )
            expect(page).to have_content(
              @internship.company_address.company.name
            )
          end

          it 'company address' do
            expect(page).to have_content(
              @internship.company_address.try(:address)
            )
          end

          it 'supervisor name and email' do
            expect(page).to have_content(
              t('search.headers.supervisor')
            )
            expect(page).to have_content(
              @internship.supervisor_name
            )
            expect(page).to have_content(
              @internship.supervisor_email
            )
          end
        end
      end

      context 'displays' do
        context 'selected filters' do
          before :each do
            @internship = create(:internship_2)
            @current_user = login_as_student
          end
          it '- none selected before search' do
            visit start_search_path
            expect(page).to have_select(
              'search_paid',
              selected: []
            )
            expect(page).to have_select(
              'search_location',
              selected: []
            )
            expect(page).to have_select(
              'search_orientation_id',
              selected: []
            )
            expect(page).to have_select(
              'search_programming_language_id',
              selected: []
            )
          end
          it '- selected after search' do
            orientation1 = create(:orientation1)
            internship1 = create(:internship, orientation: orientation1)
            pl1 = create(:brainfuck)
            internship1.programming_languages = [pl1]

            visit start_search_path
            select t('search.is_paid'), from: 'search_paid'
            select @internship.company_address.city, from: 'search_location'
            select @internship.orientation.name, from: 'search_orientation_id'
            select pl1.name, from: 'search_programming_language_id'

            click_on t('search.buttons.search')
            expect(page).to have_select(
              'search_paid',
              selected: t('search.is_paid')
            )
            expect(page).to have_select(
              'search_location',
              selected: @internship.company_address.city
            )
            expect(page).to have_select(
              'search_orientation_id',
              selected: @internship.orientation.name
            )
            expect(page).to have_select(
              'search_programming_language_id',
              selected: pl1.name
            )
          end
        end
        context 'results that' do
          it 'have already started' do
            create(:internship)
            login_as_student
            visit start_search_path
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 0.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
          end

          it 'matches payment' do
            internship = create(
              :internship,
              start_date: Date.today.to_date - 7.days,
              payment_state_id: 6
            )
            internship1 = create(
              :internship_1,
              start_date: Date.today.to_date - 7.days,
              payment_state_id: 5
            )

            login_as_student
            visit start_search_path
            select t('search.is_paid'), from: 'search_paid'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 1.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(page).to have_content(
              internship.company_address.company.name
            )
            expect(page).not_to have_content(
              internship1.company_address.company.name
            )
          end

          it 'matches location' do
            internship = create(
              :internship_1,
              start_date: Date.today.to_date - 7.days
            )
            internship1 = create(
              :internship_2,
              start_date: Date.today.to_date - 7.days
            )
            login_as_student
            visit start_search_path
            select internship1.company_address.city, from: 'search_location'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 1.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(page).to have_content(
              internship1.company_address.city,
              count: 3
            )
            expect(page).to have_content(
              internship.company_address.city,
              count: 1
            )
          end

          it 'match orientation' do
            orientation = create(:orientation)
            orientation1 = create(:orientation1)
            create(
              :internship,
              orientation: orientation,
              start_date: Date.today.to_date - 7.days
            )
            create(
              :internship,
              orientation: orientation1,
              start_date: Date.today.to_date - 7.days
            )

            login_as_student
            visit start_search_path
            select orientation.name, from: 'search_orientation_id'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 1.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(page).to have_content(orientation.name, count: 2)
            expect(page).to have_content(orientation1.name, count: 1)
          end

          it 'match programming language' do
            internship = create(
              :internship, start_date: Date.today.to_date - 7.days
            )
            internship1 = create(
              :internship, start_date: Date.today.to_date - 7.days
            )
            pl = create(:programming_language)
            pl1 = create(:brainfuck)
            internship.programming_languages = [pl]
            internship1.programming_languages = [pl1]

            login_as_student
            visit start_search_path
            select pl1.name, from: 'search_programming_language_id'
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 1.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(page).to have_content(pl1.name, count: 2)
            expect(page).to have_content(pl.name, count: 1)
          end
        end

        context 'limited results' do
          before :each do
            20.times { create_internship_with_pl }
            login_as_student
            visit start_search_path
            click_on t('search.buttons.search')
            click_on t('search.modal.confirm')
          end

          context 'for students:' do
            it '12 results' do
              expect(page).to have_content(
                t('search.results_found.start').to_s +
                ' ' + 12.to_s + ' ' +
                t('search.results_found.finish').to_s
              )
              expect(page).not_to have_content(
                t('search.headers.active_admin_link').to_s
              )
            end

            it 'same results in different searches' do
              loaded_results = page
              click_on t('search.buttons.search')
              expect(page).to equal(
                loaded_results
              )
            end
          end
        end

        context 'unlimited results' do
          before :each do
            20.times { create_internship_with_pl }
            login_as_admin
            visit start_search_path
            click_on t('search.buttons.search')
          end

          context do
            it 'for admins' do
              expect(page).to have_content(
                t('search.results_found.start').to_s +
                ' ' + 20.to_s + ' ' +
                t('search.results_found.finish').to_s
              )
            end
          end
        end
      end

      describe 'student creates a new search' do
        before :each do
          create_internship_with_pl
          @current_user = login_as_student
        end
        context 'and has searched previously' do
          it 'shows previous search results' do
            visit start_search_path
            click_on t('search.buttons.search')
            visit start_search_path
            expect(page).to have_content(
              1.to_s + t('search.previous_results').to_s
            )
            expect(page).to have_content(
              @internship.company_address.company.name
            )
          end
          it 'shows warning modal when all slots are used' do
            20.times { create_internship_with_pl }
            visit start_search_path
            click_on t('search.buttons.search')
            click_on t('search.modal.confirm')
            click_on t('search.buttons.search')
            click_on t('search.modal.return_to_search_results')
            expect(page).to have_content(
              12.to_s + t('search.previous_results').to_s
            )
            expect(page).to have_content(
              @internship.company_address.company.name
            )
          end
        end
        context 'and has no previous search' do
          it 'shows no previous search results' do
            visit start_search_path
            select t('search.is_paid'), from: 'search_paid'
            click_on t('search.buttons.search')
            visit start_search_path
            expect(page).not_to have_content(
              1.to_s + t('search.previous_results').to_s
            )
            expect(page).not_to have_content(
              @internship.company_address.company.name
            )
          end
        end
      end

      describe 'student creates a new random search' do
        before :each do
          create_internship_older_than_2yrs
          create_internship_with_pl
          @current_user = login_as_student
        end
        context 'and has not used its 12 slots'
        it 'shows one random result not older than 2 years and increases them
        used slot size' do
          visit start_search_path
          click_on t('search.buttons.random')
          expect(page).to have_content(
            t('search.results_found.start').to_s +
            ' ' + 1.to_s + ' ' +
            t('search.results_found.finish').to_s
          )
          expect(page).to have_content(
            @internship.company_address.company.name
          )
          expect(page).not_to have_content(
            @internship2.company_address.company.name
          )
          expect(UserCanSeeInternship.previous_associated_internships(
            user: @current_user
          ).count).to eql(1)
        end
        context 'and has used its 12 slots'
        it 'shows a modal with a warning and on dismiss returns to the page
        with the previous search results' do
          20.times { create_internship_with_pl }
          visit start_search_path
          click_on t('search.buttons.search')
          click_on t('search.modal.confirm')
          visit start_search_path
          click_on t('search.buttons.random')
          click_on t('search.modal.return_to_search_results')
          expect(page).to have_content(
            12.to_s + t('search.previous_results').to_s
          )
          expect(page).to have_content(
            @internship.company_address.company.name
          )
        end
      end

      describe 'admin view for search' do
        before :each do
          20.times { create_internship_with_pl }
          @current_user = login_as_admin
          visit start_search_path
        end
        context 'admin has no search limitations' do
          it 'shows no warning for search results that are more than 6' do
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 20.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
          end
          it 'shows no warning when we had 12 previous results and create a
          new search' do
            click_on t('search.buttons.search')
            visit start_search_path
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 20.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
          end
          it 'shows no warning when we had 12 previous results and create
          a random search' do
            click_on t('search.buttons.random')
            expect(page).to have_content(
              t('search.results_found.start').to_s +
              ' ' + 1.to_s + ' ' +
              t('search.results_found.finish').to_s
            )
            expect(page).to have_content(
              @internship.company_address.company.name
            )
          end
        end
        context 'admin has a link to the internship in active admin' do
          it 'shows a link on the detail card' do
            click_on t('search.buttons.search')
            expect(page).to have_content(
              t('search.headers.active_admin_link').to_s
            )
          end
        end
      end
    end
  end
end
