# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin CompanyAddress Show' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
  end
  it 'shows company_address' do
    company = create(:company)
    company_address = company.company_addresses.first
    visit admin_company_address_path(id: company_address)

    %w[street
       zip
       city
       country
       phone
       fax
       latitude
       longitude].each do |field_name|
      value = company_address.send(field_name)
      expect(page).to have_content value
    end
  end
end
