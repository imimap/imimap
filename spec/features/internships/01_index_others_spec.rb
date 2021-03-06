# frozen_string_literal: true

require 'rails_helper'

describe 'internship index - ' do
  %i[prof admin examination_office].each do |role|
    context "with role #{role}" do
      before :each do
        @user = create(role)
        sign_in(@user)
        @internship = create(:internship, semester: Semester.current)
      end
      it 'sees the link in the main menu' do
        visit root_path
        expect(page).to have_content(t('header.current_internships'))
      end
      it 'can see the list of internships' do
        visit internships_path
        expect(page).to have_content(@internship.start_date)
        expect(page).to have_content(@internship.company_address.country_name)
        expect(page).to have_content(@internship.internship_state.name)
      end
    end
  end
end
