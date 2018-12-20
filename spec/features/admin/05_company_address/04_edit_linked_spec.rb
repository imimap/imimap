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
  it 'edits company_address links' do
    company_address = create(:company_address_for_edit)
    new_company = create(:company_without_address)
    visit edit_admin_company_address_path(id: company_address)
    company_label = I18n.t('activerecord.attributes.company_address.company')
    select new_company.name, from: company_label

    click_on I18n.t('helpers.submit.update',
                    model: CompanyAddress.model_name.human)
    expect(page).to have_content(new_company.name)
  end
end
