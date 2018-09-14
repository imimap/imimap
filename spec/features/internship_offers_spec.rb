# frozen_string_literal: true

require 'rails_helper'

describe 'Display of Internship Offers' do
  context 'as user' do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
      ios = %i[internship_offer io2 io3]
      @ios = ios.map { |io| create(io) }
    end

    it 'shows the offers in the index ' do
      @ios.each do |io|
        visit internship_offers_path
        expect(page).to have_content(io.title)
        expect(page).to have_content(io.city)
        expect(page).to have_content(io.country)
      end
    end

    it 'shows one offer' do
      pending
      io = @ios[1]
      visit internship_offer_path(:de, io.id)
      expect(page).to have_content(io.title)
      expect(page).to have_content(io.city)
      expect(page).to have_content(io.country)
      expect(page).to have_content(io.body)
      expect(page).to have_content(io.pdf)
    end

    it "doesn't show the create link" do
      visit internship_offers_path
      expect(page).not_to have_content(t('activerecord.attributes.internship_offer.share'))
    end
  end

  context 'as admin' do
    before(:each) do
      @admin = create(:admin)
      sign_in(@admin)
    end
    it 'does see the create link' do
      visit internship_offers_path
      expect(page).to have_content(t('activerecord.attributes.internship_offer.share'))
    end
  end
end
