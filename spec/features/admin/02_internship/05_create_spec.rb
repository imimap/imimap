# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin create internship' do
  before :each do
    @admin_user = create :admin_user
    # login_as(@admin_user, :scope => :admin_user)
    sign_in(@admin_user)
    I18n.locale = 'en'
  end

  it 'index has edit link' do
    visit admin_internships_path
    click_on t('active_admin.create_model', model: Internship.model_name.human)
    expect(current_path).to eq new_admin_internship_path(locale: I18n.locale)
  end

  def create_test_data
    [create(:company_address_for_edit),
     create(:complete_internship),
     create(:ws2018)]
  end

  def create_internship
    ca, complete_internship, semester = create_test_data
    visit new_admin_internship_path
    select company_address_selector(company_address: ca),
           from: 'Company address'
    select student_selector(student: complete_internship.student),
           from: 'Complete internship'
    select semester.name, from: 'Semester'
    click_on 'Praktikum anlegen'
    [complete_internship, semester]
  end

  it 'creates and shows internship' do
    complete_internship, semester = create_internship
    expect(page).to have_content complete_internship.student.name
    expect(page).to have_content complete_internship.id
    expect(page).to have_content semester.name
    expect(page).to have_content ca.company.name
  end
  it 'creates internship in database' do
    complete_internship, semester = create_internship
    save_and_open_page
    @i = Internship.last
    expect(@i.student.name).to eq complete_internship.student.name
    expect(@i.semester.name).to eq semester.name
    expect(@i.company_v2.name).to eq ca.company.name
  end
end
