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
  it 'creates and shows internship' do
    ca = create(:company_address_for_edit)
    student = create(:student2)
    semester = create(:ws2018)
    visit new_admin_internship_path

    select company_address_selector(company_address: ca),
           from: 'Company address'
    select student_selector(student: student), from: 'Student'
    select semester.name, from: 'Semester'
    click_on 'Praktikum anlegen'
    expect(page).to have_content student.name
    expect(page).to have_content semester.name
    expect(page).to have_content ca.company.name
  end
  it 'creates internship in database' do
    ca = create(:company_address_for_edit)
    student = create(:student2)
    semester = create(:ws2018)
    visit new_admin_internship_path
    select company_address_selector(company_address: ca),
           from: 'Company address'
    select student_selector(student: student), from: 'Student'
    select semester.name, from: 'Semester'
    click_on 'Praktikum anlegen'
    @i = Internship.last
    expect(@i.student.name).to eq student.name
    expect(@i.semester.name).to eq semester.name
    expect(@i.company_v2.name).to eq ca.company.name
  end
end
