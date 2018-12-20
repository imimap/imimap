# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'
# country
describe 'ActiveAdmin CompanyAddress Show' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
  end
  it 'edits company_address' do
    fields = %w[street zip city phone fax latitude longitude]
    company = create(:company)
    company_address = company.company_addresses.first
    new_address = create(:company_address_is24)
    visit edit_admin_company_address_path(id: company_address)
    fields.each do |field_name|
      i18n_key = "activerecord.attributes.company_address.#{field_name}"
      fill_in t(i18n_key), with: new_address.send(field_name)
    end
    click_on I18n.t('helpers.submit.update',
                    model: CompanyAddress.model_name.human)
    fields.each do |field_name|
      expect(page).to have_content(new_address.send(field_name))
    end
  end
end
