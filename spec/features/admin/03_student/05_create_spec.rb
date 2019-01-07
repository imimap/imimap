# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Create Student from index path' do
  before :each do
    sign_in create(:admin_user)
    @student = build(:student)
    visit admin_students_path
  end
  it 'create button is available' do
    expect(page).to have_content I18n.t('activerecord.models.student.other')
    click_on t('active_admin.create_model', model: Student.model_name.human)
    expect(page).to have_content t('active_admin.create_model',
                                   model: Student.model_name.human)
  end
  it 'create works' do
    click_on t('active_admin.create_model', model: Student.model_name.human)
    field_names = %w[enrolment_number first_name last_name
                     birthplace birthday email]
    field_names.each do |field_name|
      fill_in t("activerecord.attributes.student.#{field_name}"),
              with: @student.send(field_name)
    end
    click_on 'Student_in anlegen'
    date_string = I18n.l(@student.birthday, format: :long)
    expect(page).to have_content(date_string)
    (field_names - %w[birthday]).each do |field_name|
      expect(page).to have_content @student.send(field_name)
    end
  end
end
