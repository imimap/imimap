# frozen_string_literal: true

require 'rails_helper'

describe 'Index of internship offers' do
  context 'a student' do
    before :each do
      @user = create(:student_user)
      sign_in(@user)
      ios = %i[internship_offer io2 io3]
      @ios = ios.map { |io| create(io) }
      @iox = create(:iox)
    end

    it 'shows the offers in the index ' do
      @ios.each do |io|
        visit internship_offers_path
        expect(page).to have_content(io.title)
        expect(page).to have_content(io.city)
        expect(page).to have_content(io.country)
      end
    end

    it 'does not show inactive offer' do
      visit internship_offers_path
      expect(page).not_to have_content(@iox.title)
      expect(page).not_to have_content(@iox.city)
      expect(page).not_to have_content(@iox.country)
    end
  end
end
