# frozen_string_literal: true

require 'rails_helper'

describe 'Creation of internship offers' do
  [['student_user', false],
   ['prof', false],
   ['examination_office', false],
   ['admin', true]].each do |role, should_see_create_link|
    context "with role '#{role}'" do
      before :each do
        @user = create(role)
        sign_in(@user)
        @internship = create(:internship)
      end

      it "should #{should_see_create_link ? ' ' : 'NOT '}see the create link" do
        text =  t('activerecord.attributes.internship_offer.share')
        visit internship_offers_path
        if should_see_create_link
          expect(page).to have_content(text)
        else
          expect(page).not_to have_content(text)
        end
      end
    end
  end
end
