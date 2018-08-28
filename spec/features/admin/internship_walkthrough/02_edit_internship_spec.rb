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
      @ca = create(:company_address_for_edit)
    end
    describe 'show internship' do
      it 'shows internship' do
        visit admin_internship_path(id: @internship)
        click_on t('internships.edit.editinternship')
        expect(page).not_to have_content 'NoMethodError'
        expect(page).to have_content t('internships.edit.editinternship')
        old_ca = @internship.company_address
        name = @ca.company.name
        street = @ca.street
        city = @ca.city
        country = @ca.country
        select "#{name}, #{street}, #{city}, #{country}", from: 'Company address'
        click_on t('internships.update')
        expect(page).to have_content @ca.company.name
        expect(page).not_to have_content old_ca.company.name
      end
    end
  end
end
