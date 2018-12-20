# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin edit internship' do
  include CompanyAddressesHelper
  context 'logged in' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
      @internship = create(:internship)
      @ca = create(:company_address_for_edit)
    end
    describe 'change associated company address' do
      it 'shows internship' do
        visit admin_internship_path(id: @internship)
        click_on t('internships.edit.editinternship')
        expect(page).not_to have_content 'NoMethodError'
        expect(page).to have_content t('internships.edit.editinternship')
        old_ca = @internship.company_address
        select company_address_selector(company_address: @ca), from: 'Company address'
        click_on t('internships.update')
        expect(page).to have_content @ca.company.name
        expect(page).not_to have_content old_ca.company.name
      end
    end
    describe 'controller' do
      it 'update' do
        @programming_language = create(:programming_language)
        visit edit_admin_internship_path(id: @internship)
        have_select Internship.human_attribute_name(:programming_languages),
                                                    with: @programming_language.name
        click_on t('helpers.submit.update', model: Internship.model_name.human)
        expect(page).to have_content @programming_language.name
      end
    end
  end
end
