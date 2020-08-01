# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers'

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
  it 'sets approved' do
    [true, false].each do |set_to|
      @internship.approved = !set_to
      @internship.save
      visit admin_internship_path(id: @internship)
      click_on t('internships.edit.editinternship')
      check_or_uncheck = set_to ? 'check' : 'uncheck'
      send(check_or_uncheck, 'internship_approved')
      click_on t('internships.update')
      @internship.reload
      expect(@internship.approved).to be set_to
    end
  end
  it 'sets approved' do
    @internship.approved = false
    @internship.save
    visit admin_internship_path(id: @internship)
    click_on t('internships.edit.editinternship')
    check 'internship_approved'
    click_on t('internships.update')
    @internship.reload
    expect(@internship.approved).to be true
  end

  it 'sets certificate_signed_by_internship_officer' do
    date = Date.new(2011, 11, 25)
    date_s = date.strftime('%d-%m-%Y')
    visit admin_internship_path(id: @internship)
    click_on t('internships.edit.editinternship')
    field = 'certificate_signed_by_internship_officer'
    field_label = t("activerecord.attributes.internship.#{field}")
    fill_in field_label, with: date_s
    click_on t('internships.update')
    @internship.reload
    expect(@internship.certificate_signed_by_internship_officer)
      .to eq date
  end
end
