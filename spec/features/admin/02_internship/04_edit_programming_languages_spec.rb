# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin edit internship' do
  include CompanyAddressesHelper
  before :each do
    sign_in create(:admin_user)
    I18n.locale = 'de'
    @internship = create(:internship)
    @programming_language = create(:programming_language)
  end
  it 'updates associated programming_languages' do
    visit edit_admin_internship_path(id: @internship)
    select @programming_language.name,
           from: Internship.human_attribute_name(:programming_languages)
    click_on t('helpers.submit.update', model: Internship.model_name.human)
    expect(page).to have_content @programming_language.name
  end
  it 'updates several programming_languages'
end
