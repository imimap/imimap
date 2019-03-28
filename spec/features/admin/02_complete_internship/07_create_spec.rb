# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin create CompleteInternship' do
  before :each do
    @admin_user = create :admin_user
    sign_in(@admin_user)
    I18n.locale = 'en'
  end

  it 'index has edit link' do
    visit admin_complete_internships_path
    click_on t('active_admin.create_model',
               model: CompleteInternship.model_name.human)
    expect(current_path)
      .to eq new_admin_complete_internship_path(locale: I18n.locale)
  end

  def create_complete_internship
    student = create(:student2)
    semester = create(:ws2018)
    visit new_admin_complete_internship_path
    select student_selector(student: student), from: 'Student'
    select semester.name, from: 'Semester'
    click_on 'Praktikumsübersicht anlegen'
    [student, semester]
  end

  it 'creates and shows complete internship' do
    student, semester = create_complete_internship
    expect(page).to have_content student.name
    expect(page).to have_content semester.name
  end

  it 'creates internship in database' do
    student, semester = create_complete_internship
    @ci = CompleteInternship.last
    expect(@ci.student.name).to eq student.name
    expect(@ci.semester.name).to eq semester.name
  end
end
