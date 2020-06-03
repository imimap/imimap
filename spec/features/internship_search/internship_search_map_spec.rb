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

  I18n.available_locales.each do |locale|
    context "in locale #{locale}" do
      before :each do
        I18n.locale = locale
        allow_ldap_login(success: false)
      end

      describe 'internship search results map' do
        before :each do
          create_internship_with_pl
          login_as_student
          visit start_search_path
          click_on t('search.buttons.search')
        end

        it 'shows a button for the map results' do
          expect(page).to have_button('Karte zeigen')
          expect(page).to have_css('#map-results', visible: false)
        end

        it 'shows a button for the list results' do
          click_button('Karte zeigen')
          expect(page).to have_css('#search-results', visible: false)
          expect(page).to have_css('#map-results', visible: true)
        end

        it 'show the internship on the map' do
          click_button('Karte zeigen')
          expect(page.body).to have_content(@internship.orientation.name)
        end
      end
    end
  end
end
