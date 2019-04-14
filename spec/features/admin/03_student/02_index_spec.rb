# frozen_string_literal: true

require 'rails_helper'
require_relative '../helpers/active_admin_spec_helpers.rb'

describe 'ActiveAdmin Student / Index' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'de'
    @student = create(:student)
  end
  it 'shows students details headers' do
    visit admin_students_path
    expect(page)
      .to have_content t('activerecord.attributes.student.first_name')
    expect(page)
      .to have_content t('activerecord.attributes.student.last_name')
    expect(page).to have_content t('activerecord.attributes.student.email')
  end
  it 'shows students details data' do
    visit admin_students_path
    expect(page).to have_content @student.last_name
    expect(page).to have_content @student.first_name
    expect(page).to have_content @student.enrolment_number
    expect(page).to have_content @student.email
    @student.internships.map(&:id).each do |_internship_id|
      expect(page).to have_content @student.internship_id
    end
  end
  it 'has link to Student' do
    visit admin_students_path
    click_on @student.enrolment_number
    expect(current_path).to eq admin_student_path(id: @student,
                                                  locale: I18n.locale)
  end
  it 'has link to Student' do
    visit admin_students_path
    click_on t('active_admin.view')
    expect(current_path)
      .to eq admin_student_path(id: @student, locale: I18n.locale)
  end

  it 'link to internship works for student with 2 internships' do
    create(:internship_2, student: @student)
    visit admin_students_path
    @student.internships.map(&:id).each do |internship_id|
      click_on "internship-#{internship_id}"
      expect(current_path).to(
        eq admin_internship_path(id: internship_id,
                                 locale: I18n.locale)
      )
    end
  end
end
