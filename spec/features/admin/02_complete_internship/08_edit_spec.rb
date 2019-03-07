# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin edit internship' do
  include CompanyAddressesHelper
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
    @internship = create(:internship)
    @ca = create(:company_address_for_edit)
  end
  it 'change associated company address' do
    visit admin_internship_path(id: @internship)
    click_on t('internships.edit.editinternship')
    expect(page).not_to have_content 'NoMethodError'
    expect(page).to have_content t('internships.edit.editinternship')
    old_ca = @internship.company_address
    select company_address_selector(company_address: @ca),
           from: 'Company address'
    click_on t('internships.update')
    expect(page).to have_content @ca.company.name
    expect(page).not_to have_content old_ca.company.name
  end
end
