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

    it 'shows one offer' do
      io = @ios[1]
      visit internship_offer_path(:de, io.id)
      expect(page).to have_content(io.title)
      expect(page).to have_content(io.city)
      expect(page).to have_content(io.country)
      expect(page).to have_content(io.body[0..20].strip)
      #expect(page).to have_content(io.pdf)
    end
  end
end
