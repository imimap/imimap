# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Create Student' do
  before :each do
    @admin_user = create :admin_user
    sign_in @admin_user
    I18n.locale = 'en'
    @student = build(:student)
  end
  describe 'from index' do
    before :each do
      visit admin_students_path
      expect(I18n.locale).to eq :de
    end
    it 'create button is available' do
      expect(page).to have_content I18n.t('activerecord.models.student.other')
      click_on t('active_admin.create_model', model: Student.model_name.human)
      expect(page).to have_content t('active_admin.create_model', model: Student.model_name.human)
    end
    it 'create works' do
      click_on t('active_admin.create_model', model: Student.model_name.human)
      fill_in t('activerecord.attributes.student.enrolment_number'), with: @student.enrolment_number

      fill_in t('activerecord.attributes.student.first_name'), with: @student.first_name
      fill_in t('activerecord.attributes.student.last_name'), with: @student.last_name
      fill_in t('activerecord.attributes.student.birthplace'), with: @student.birthplace
      fill_in t('activerecord.attributes.student.birthday'), with: @student.birthday
      fill_in t('activerecord.attributes.student.email'), with: @student.email

      #click_on t('helpers.submit.create', model: Student.model_name.human)
      # click_on t('active_admin.create_model', model: Student.model_name.human)
      click_on 'Student_in anlegen'
      expect(page).to have_content @student.first_name


    end
  end
end
