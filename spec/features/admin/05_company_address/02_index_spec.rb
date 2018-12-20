# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin CompanyAddress / index' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
  end

  it 'shows company_address details' do
    ca1 = create(:company_address_1)
    ca2 = create(:company_address_2)
    visit admin_company_addresses_path
    [ca1, ca2].each do |ca|
      %w[street
         zip
         city
         country
         phone
         fax
         latitude
         longitude].each do |field_name|
        value = ca.send(field_name)
        expect(page).to have_content value
      end
    end
  end
end
