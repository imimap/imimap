# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin Edit Internship' do
  context 'logged in' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
      @internship = create(:internship)
    end
    describe 'show internship' do
      it 'shows internship' do
        visit admin_internship_path(id: @internship)
        click_on t('internships.edit.editinternship')
        expect(page).not_to have_content 'NoMethodError'
        expect(page).to have_content t('internships.edit.editinternship')
      end
    end
  end
end
