# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin CompanyAddress / index' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
  end

  it 'has link to Company' do
    c1 = create(:company_is24)
    c2 = create(:company)
    [c1, c2].each do |company|
      visit admin_company_addresses_path
      click_on company.name
      expect(current_path).to eq admin_company_path(
        id: company,
        locale: I18n.locale
      )
    end
  end
end
